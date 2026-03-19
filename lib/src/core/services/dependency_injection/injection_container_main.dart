part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final preference = await SharedPreferences.getInstance();
  final dio = Dio();
  final api = const API();
  final packageInfo = await PackageInfo.fromPlatform();

  await _initCore(
    preference: preference,
    dio: dio,
    api: api,
    packageInfo: packageInfo,
  );
}

Future<void> _initCore({
  required SharedPreferences preference,
  required Dio dio,
  required API api,
  required PackageInfo packageInfo,
}) async {
  sl
    ..registerLazySingleton(() => preference)
    ..registerLazySingleton(() => dio)
    ..registerLazySingleton(() => api)
    ..registerLazySingleton(() => packageInfo)
    ..registerLazySingleton<SessionLocalDataSource>(
      () => SessionLocalDataSourceImpl(sl()),
    )
    ..registerLazySingleton<PermissionGateway>(() => PermissionGatewayImpl())
    ..registerLazySingleton<SessionRepository>(
      () => SessionRepositoryImpl(sl()),
    )
    ..registerLazySingleton<PermissionRepository>(
      () => PermissionRepositoryImpl(sl()),
    )
    ..registerLazySingleton(() => GetStartupSession(sl()))
    ..registerLazySingleton(() => CheckCameraPermission(sl()))
    ..registerLazySingleton(() => CheckNotificationPermission(sl()))
    ..registerLazySingleton(() => RequestCameraPermission(sl()))
    ..registerLazySingleton(() => RequestNotificationPermission(sl()))
    ..registerLazySingleton(() => OpenPermissionSettings(sl()))
    ..registerLazySingleton(() => CompleteOnboarding(sl()))
    ..registerLazySingleton(() => SaveSignedInRole(sl()))
    ..registerLazySingleton(() => ClearSession(sl()))
    ..registerLazySingleton<UrlLauncherGateway>(() => UrlLauncherGatewayImpl());

  sl.registerFactory(
    () => AuthBloc(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
}
