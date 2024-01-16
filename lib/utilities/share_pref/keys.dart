part of 'app_prefs.dart';

enum AppPrefKey {
  skipAddUserDetails('skipAddUserDetailPage'),
  userID('user_id');

  const AppPrefKey(this.key);
  final String key;
}
