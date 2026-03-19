import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/app_shell/presentation/providers/app_shell_provider.dart';
import '../res/typography.dart';

/// {@template context_extension}
/// Handy helpers on [BuildContext] focusing on phones & tablets:
/// - Theming (theme, colorScheme, textTheme, AppTextStyles)
/// - MediaQuery (size, paddings, insets, orientation, DPR)
/// - Design-frame scaling (width/height scale, scalar)
/// - Breakpoints simplified: `isPhone`, `isTablet`
/// - Responsive value picker: `responsivePT<T>(phone: ..., tablet: ...)`
/// {@endtemplate}
extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  AppTextStyles get textStyles => AppTextStyles.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => MediaQuery.sizeOf(this);

  double get width => size.width;

  double get height => size.height;

  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  Orientation get orientation => MediaQuery.orientationOf(this);

  bool get isPortrait => orientation == Orientation.portrait;

  bool get isLandscape => orientation == Orientation.landscape;

  double get topSafe => MediaQuery.paddingOf(this).top;

  double get bottomSafe => MediaQuery.paddingOf(this).bottom;

  double get navBarHeight => MediaQuery.viewPaddingOf(this).bottom;

  bool get isKeyboardOpen => MediaQuery.viewInsetsOf(this).bottom > 0;

  double get shortestSide => size.shortestSide;

  static const double _designWidth = 440;
  static const double _designHeight = 956;

  double get widthScale => width / _designWidth;

  double get heightScale => height / _designHeight;

  double scale(num value, {bool byHeight = false}) =>
      (byHeight ? heightScale : widthScale) * value;

  static const double _bpTabletMin = 600;

  bool get isTablet => shortestSide >= _bpTabletMin;

  bool get isPhone => !isTablet;

  T responsivePT<T>({required T phone, required T tablet}) =>
      isTablet ? tablet : phone;

  int get gridColumns {
    if (isTablet) return isLandscape ? 6 : 4;
    return isLandscape ? 3 : 2;
  }

  bool get isDarkMode => theme.brightness == Brightness.dark;

  AuthBloc get authBloc => read<AuthBloc>();

  AuthBloc watchAuthBloc() => watch<AuthBloc>();

  R selectAuthBloc<R>(
    R Function(AuthBloc bloc) selector,
  ) => select<AuthBloc, R>(selector);

  AppShellProvider get appShellProvider => read<AppShellProvider>();

  AppShellProvider watchAppShellProvider() => watch<AppShellProvider>();

  R selectAppShellProvider<R>(
    R Function(AppShellProvider provider) selector,
  ) => select<AppShellProvider, R>(selector);
}
