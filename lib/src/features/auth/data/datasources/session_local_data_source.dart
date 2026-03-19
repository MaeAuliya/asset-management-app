import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/enums/user_role.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/preference_keys.dart';

abstract class SessionLocalDataSource {
  Future<bool> isFirstOpen();

  Future<bool> isOnboardingCompleted();

  Future<bool> isSignedIn();

  Future<UserRole?> getSignedInRole();

  Future<void> completeOnboarding();

  Future<void> saveSignedInRole(UserRole role);

  Future<void> clearSession();
}

class SessionLocalDataSourceImpl implements SessionLocalDataSource {
  const SessionLocalDataSourceImpl(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<bool> isFirstOpen() async =>
      !(_preferences.getBool(PreferenceKeys.kHasOpenedApp) ?? false);

  @override
  Future<bool> isOnboardingCompleted() async =>
      _preferences.getBool(PreferenceKeys.kOnboardingCompleted) ?? false;

  @override
  Future<bool> isSignedIn() async =>
      _preferences.getBool(PreferenceKeys.kSignedIn) ?? false;

  @override
  Future<UserRole?> getSignedInRole() async {
    final value = _preferences.getString(PreferenceKeys.kSignedInRole);

    switch (value) {
      case 'user':
        return UserRole.user;
      case 'admin':
        return UserRole.admin;
      default:
        return null;
    }
  }

  @override
  Future<void> completeOnboarding() async {
    final hasOpenedSaved = await _preferences.setBool(
      PreferenceKeys.kHasOpenedApp,
      true,
    );
    if (!hasOpenedSaved) {
      throw const LocalException(
        message: 'Unable to persist first-open state.',
      );
    }

    final onboardingSaved = await _preferences.setBool(
      PreferenceKeys.kOnboardingCompleted,
      true,
    );
    if (!onboardingSaved) {
      throw const LocalException(
        message: 'Unable to persist onboarding state.',
      );
    }
  }

  @override
  Future<void> saveSignedInRole(UserRole role) async {
    final hasOpenedSaved = await _preferences.setBool(
      PreferenceKeys.kHasOpenedApp,
      true,
    );
    if (!hasOpenedSaved) {
      throw const LocalException(
        message: 'Unable to persist first-open state.',
      );
    }

    final onboardingSaved = await _preferences.setBool(
      PreferenceKeys.kOnboardingCompleted,
      true,
    );
    if (!onboardingSaved) {
      throw const LocalException(
        message: 'Unable to persist onboarding state.',
      );
    }

    final signedInSaved = await _preferences.setBool(
      PreferenceKeys.kSignedIn,
      true,
    );
    if (!signedInSaved) {
      throw const LocalException(
        message: 'Unable to persist sign-in state.',
      );
    }

    final roleSaved = await _preferences.setString(
      PreferenceKeys.kSignedInRole,
      role.name,
    );
    if (!roleSaved) {
      throw const LocalException(
        message: 'Unable to persist signed-in role.',
      );
    }
  }

  @override
  Future<void> clearSession() async {
    final signedInSaved = await _preferences.setBool(
      PreferenceKeys.kSignedIn,
      false,
    );
    if (!signedInSaved) {
      throw const LocalException(
        message: 'Unable to clear sign-in state.',
      );
    }

    final roleRemoved = await _preferences.remove(PreferenceKeys.kSignedInRole);
    if (!roleRemoved) {
      throw const LocalException(
        message: 'Unable to clear signed-in role.',
      );
    }
  }
}
