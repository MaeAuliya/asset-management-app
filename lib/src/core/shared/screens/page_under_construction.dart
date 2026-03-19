import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../extensions/context_extension.dart';
import '../../res/media_res.dart';
import '../../res/texts.dart';
import '../../res/typography.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({
    this.title = 'Page Under Construction',
    this.message = Texts.pageUnderConstruction,
    super.key,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: context.heightScale * 18,
          children: [
            SvgPicture.asset(MediaRes.pageNotFoundVector),
            CoreText(title, role: TextRole.titleLg, textAlign: TextAlign.center),
            CoreText(message, textAlign: TextAlign.center, maxLines: 4),
          ],
        ),
      ),
    );
  }
}
