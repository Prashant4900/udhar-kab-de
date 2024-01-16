part of 'app_prefs.dart';

class AppPrefHelper {
  static Future<bool> setUserID(String userID) async {
    return AppPref.save(AppPrefKey.userID, userID);
  }

  static String getUserID() {
    return AppPref.get(AppPrefKey.userID, '') as String;
  }

  static Future<bool> setUserSkipDetails({required bool skip}) async {
    return AppPref.save(AppPrefKey.skipAddUserDetails, skip);
  }

  static bool getUserSkipDetails() {
    return AppPref.get(AppPrefKey.skipAddUserDetails, false) as bool;
  }

  static Future<bool> deleteUserID() {
    return AppPref.remove(AppPrefKey.userID);
  }
}
