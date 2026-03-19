import fs from 'node:fs';
import path from 'node:path';
import os from 'node:os';
import { pathToFileURL } from 'node:url';

const GEMINI_MODEL = 'gemini-2.5-flash';

function parseArgs(argv) {
  const args = {
    cwd: process.cwd(),
    days: 30,
    bootstrapTailLines: 400,
    minSalience: 0.25,
  };

  for (let i = 0; i < argv.length; i += 1) {
    const arg = argv[i];
    if (arg === '--cwd' && argv[i + 1]) {
      args.cwd = path.resolve(argv[++i]);
    } else if (arg === '--days' && argv[i + 1]) {
      args.days = Number(argv[++i]);
    } else if (arg === '--bootstrap-tail-lines' && argv[i + 1]) {
      args.bootstrapTailLines = Number(argv[++i]);
    } else if (arg === '--min-salience' && argv[i + 1]) {
      args.minSalience = Number(argv[++i]);
    }
  }

  return args;
}

function normalizePath(value) {
  return path.resolve(value).replace(/\\/g, '/').toLowerCase();
}

function ensureDir(dirPath) {
  fs.mkdirSync(dirPath, { recursive: true });
}

function readJson(filePath, fallback) {
  if (!fs.existsSync(filePath)) return fallback;
  try {
    return JSON.parse(fs.readFileSync(filePath, 'utf8'));
  } catch {
    return fallback;
  }
}

function writeJson(filePath, data) {
  ensureDir(path.dirname(filePath));
  fs.writeFileSync(filePath, JSON.stringify(data, null, 2));
}

function findSessionFiles(rootDir, maxAgeDays) {
  if (!fs.existsSync(rootDir)) return [];
  const cutoff = Date.now() - maxAgeDays * 24 * 60 * 60 * 1000;
  const files = [];

  function walk(dir) {
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
      const fullPath = path.join(dir, entry.name);
      if (entry.isDirectory()) {
        walk(fullPath);
        continue;
      }
      if (!entry.isFile() || !entry.name.endsWith('.jsonl')) continue;
      const stat = fs.statSync(fullPath);
      if (stat.mtimeMs >= cutoff) {
        files.push({ path: fullPath, mtimeMs: stat.mtimeMs });
      }
    }
  }

  walk(rootDir);
  return files.sort((a, b) => a.mtimeMs - b.mtimeMs);
}

function extractProjectCwd(lines) {
  const probeCount = Math.min(lines.length, 80);
  for (let i = 0; i < probeCount; i += 1) {
    try {
      const entry = JSON.parse(lines[i]);
      const payload = entry.payload ?? {};
      if (typeof payload.cwd === 'string' && payload.cwd.length > 0) {
        return payload.cwd;
      }
    } catch {
      // ignore malformed lines
    }
  }
  return null;
}

function extractSessionId(filePath, lines) {
  for (let i = 0; i < Math.min(lines.length, 20); i += 1) {
    try {
      const entry = JSON.parse(lines[i]);
      const id = entry?.payload?.id;
      if (typeof id === 'string' && id.length > 0) return id;
    } catch {
      // ignore malformed lines
    }
  }
  return path.basename(filePath, '.jsonl');
}

function textFromContentItems(items) {
  if (!Array.isArray(items)) return '';
  return items
    .filter((item) => item && typeof item === 'object' && typeof item.text === 'string')
    .map((item) => item.text.trim())
    .filter(Boolean)
    .join('\n')
    .trim();
}

function parseTurns(lines, startLine) {
  const turns = [];

  for (let i = startLine; i < lines.length; i += 1) {
    const rawLine = lines[i]?.trim();
    if (!rawLine) continue;

    try {
      const entry = JSON.parse(rawLine);
      if (entry.type !== 'response_item') continue;
      const payload = entry.payload;
      if (!payload || payload.type !== 'message') continue;
      if (payload.role !== 'user' && payload.role !== 'assistant') continue;

      const text = textFromContentItems(payload.content);
      if (!text || text.length < 20) continue;

      turns.push({ role: payload.role, text });
    } catch {
      // ignore malformed lines
    }
  }

  return turns;
}

function chunkTurns(turns, maxChars = 6000, minChars = 300) {
  const chunks = [];
  let current = '';

  for (const turn of turns) {
    const prefix = turn.role === 'user' ? 'User' : 'Assistant';
    const line = `${prefix}: ${turn.text}\n\n`;

    if (current.length + line.length > maxChars && current.length >= minChars) {
      chunks.push(current.trim());
      current = '';
    }

    current += line;
  }

  if (current.trim().length >= minChars) {
    chunks.push(current.trim());
  }

  return chunks;
}

function loadGeminiApiKey() {
  if (process.env.GEMINI_API_KEY) return process.env.GEMINI_API_KEY;

  const configPath = path.join(os.homedir(), '.codex', 'config.toml');
  if (!fs.existsSync(configPath)) return '';

  const content = fs.readFileSync(configPath, 'utf8');
  const match = content.match(/\[mcp_servers\.engram\.env\][\s\S]*?GEMINI_API_KEY\s*=\s*"([^"]+)"/);
  return match?.[1] ?? '';
}

function resolveEngramSdkPath() {
  if (process.env.ENGRAM_SDK_PATH && fs.existsSync(process.env.ENGRAM_SDK_PATH)) {
    return process.env.ENGRAM_SDK_PATH;
  }

  const candidates = [
    path.join(process.env.APPDATA ?? '', 'npm', 'node_modules', 'engram-sdk', 'dist', 'index.js'),
    path.join(os.homedir(), 'AppData', 'Roaming', 'npm', 'node_modules', 'engram-sdk', 'dist', 'index.js'),
    path.join(os.homedir(), '.npm-global', 'lib', 'node_modules', 'engram-sdk', 'dist', 'index.js'),
    '/usr/local/lib/node_modules/engram-sdk/dist/index.js',
  ].filter(Boolean);

  const found = candidates.find((candidate) => fs.existsSync(candidate));
  if (!found) {
    throw new Error('Unable to locate engram-sdk dist/index.js. Set ENGRAM_SDK_PATH first.');
  }

  return found;
}

function safeParseJson(text) {
  try {
    return JSON.parse(text);
  } catch {
    const match = text.match(/\{[\s\S]*\}/);
    if (!match) return { memories: [] };
    try {
      return JSON.parse(match[0]);
    } catch {
      return { memories: [] };
    }
  }
}

async function extractMemoriesWithGemini(chunk, apiKey, minSalience) {
  const prompt = `You are a memory extraction engine for an AI coding session. Analyze this Codex conversation segment and extract structured memories worth keeping for future project sessions.\n\nCONVERSATION:\n${chunk}\n\nExtract only durable context such as decisions, project conventions, architecture choices, agreed naming, implementation progress, and explicit next steps. Ignore tool noise and filler.\n\nReturn JSON in this shape:\n{"memories":[{"content":"...","type":"episodic|semantic|procedural","entities":["..."],"topics":["..."],"salience":0.0,"confidence":0.0,"status":"active|pending"}]}\n\nBe selective. Most chunks should yield 1-6 memories.`;

  const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent?key=${apiKey}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      contents: [{ parts: [{ text: prompt }] }],
      generationConfig: {
        responseMimeType: 'application/json',
        maxOutputTokens: 2048,
      },
    }),
  });

  if (!response.ok) {
    throw new Error(`Gemini API error: ${response.status}`);
  }

  const data = await response.json();
  const text = data?.candidates?.[0]?.content?.parts?.[0]?.text ?? '{}';
  const parsed = safeParseJson(text);
  return (parsed.memories ?? []).filter((memory) => (memory.salience ?? 0) >= minSalience && typeof memory.content === 'string' && memory.content.trim().length > 0);
}

function rememberChunk(vault, chunk, sessionId) {
  const memory = vault.remember({
    content: chunk,
    type: 'episodic',
    topics: ['codex-session', 'auto-ingested'],
    salience: 0.5,
    source: {
      type: 'conversation',
      sessionId,
      agentId: 'codex',
    },
  });
  return memory ? 1 : 0;
}

async function main() {
  const args = parseArgs(process.argv.slice(2));
  const workspaceCwd = normalizePath(args.cwd);
  const sessionsRoot = path.join(os.homedir(), '.codex', 'sessions');
  const statePath = path.join(os.homedir(), '.config', 'engram', 'codex-ingest-state.json');
  const state = readJson(statePath, {
    workspaceBySession: {},
    lastIngestedLine: {},
    lastRunAt: new Date(0).toISOString(),
    totalRuns: 0,
    totalMemoriesCreated: 0,
  });

  const sdkPath = resolveEngramSdkPath();
  const sdk = await import(pathToFileURL(sdkPath).href);
  const geminiApiKey = loadGeminiApiKey();
  const vault = new sdk.Vault({
    owner: 'default',
    dbPath: path.join(os.homedir(), '.engram', 'default.db'),
    agentId: 'codex',
  });

  const sessionFiles = findSessionFiles(sessionsRoot, args.days);
  let sessionsProcessed = 0;
  let chunksProcessed = 0;
  let memoriesCreated = 0;

  for (const file of sessionFiles) {
    const content = fs.readFileSync(file.path, 'utf8');
    const lines = content.split(/\r?\n/).filter(Boolean);
    if (lines.length === 0) continue;

    const projectCwd = extractProjectCwd(lines);
    if (!projectCwd || normalizePath(projectCwd) !== workspaceCwd) {
      continue;
    }

    const sessionId = extractSessionId(file.path, lines);
    const stateKey = normalizePath(file.path);
    const previousLine = state.lastIngestedLine[stateKey] ?? 0;
    let startLine = previousLine;

    if (previousLine === 0 && args.bootstrapTailLines > 0 && lines.length > args.bootstrapTailLines) {
      startLine = lines.length - args.bootstrapTailLines;
    }

    const turns = parseTurns(lines, startLine);
    state.workspaceBySession[stateKey] = workspaceCwd;
    state.lastIngestedLine[stateKey] = lines.length;

    if (turns.length === 0) continue;

    const chunks = chunkTurns(turns);
    if (chunks.length === 0) continue;

    sessionsProcessed += 1;

    for (const chunk of chunks) {
      let createdThisChunk = 0;

      if (geminiApiKey) {
        try {
          const extracted = await extractMemoriesWithGemini(chunk, geminiApiKey, args.minSalience);
          for (const memory of extracted) {
            vault.remember({
              content: memory.content,
              type: memory.type ?? 'episodic',
              entities: memory.entities ?? [],
              topics: [...(memory.topics ?? []), 'codex-session', 'auto-ingested'],
              salience: memory.salience ?? 0.5,
              confidence: memory.confidence ?? 0.8,
              status: memory.status ?? 'active',
              source: {
                type: 'conversation',
                sessionId,
                agentId: 'codex',
              },
            });
            createdThisChunk += 1;
          }
        } catch {
          createdThisChunk = rememberChunk(vault, chunk, sessionId);
        }
      } else {
        createdThisChunk = rememberChunk(vault, chunk, sessionId);
      }

      chunksProcessed += 1;
      memoriesCreated += createdThisChunk;
    }
  }

  await vault.close();

  state.lastRunAt = new Date().toISOString();
  state.totalRuns = (state.totalRuns ?? 0) + 1;
  state.totalMemoriesCreated = (state.totalMemoriesCreated ?? 0) + memoriesCreated;
  writeJson(statePath, state);

  console.log(JSON.stringify({
    workspace: args.cwd,
    sessionsProcessed,
    chunksProcessed,
    memoriesCreated,
    statePath,
    usedGemini: Boolean(geminiApiKey),
  }, null, 2));
}

main().catch((error) => {
  console.error(error instanceof Error ? error.message : String(error));
  process.exit(1);
});
