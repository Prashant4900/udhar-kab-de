import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:mobile/repositories/user_repository.dart';
import 'package:mobile/service/app_client.dart';
import 'package:mobile/setup.dart';
import 'package:mobile/utilities/share_pref/app_prefs.dart';

class AuthRepository {
  final _account = AppWriteClient.account;
  final _database = AppWriteClient.database;
  final _userRepository = getIt<UserRepository>();

  Future<User> getCurrentSessionUser() async {
    try {
      final user = await _account.get();
      await Future<void>.delayed(const Duration(microseconds: 500));
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      await _account.createOAuth2Session(provider: 'google');
      await Future<void>.delayed(const Duration(microseconds: 500));

      final user = await getCurrentSessionUser();
      log('username: ${user.name}, email: ${user.email}, id: ${user.$id}');
      await insertOrUpdateUser(user);
      await AppPrefHelper.setUserID(user.$id);
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> initiatePhoneAuth(String phone) async {
    try {
      final sessionToken = await _account.createPhoneSession(
        userId: ID.unique(),
        phone: phone,
      );
      log(sessionToken.userId);
      return sessionToken.userId;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> validateOTP(String userId, String otp) async {
    try {
      final session = await _account.updatePhoneSession(
        userId: userId,
        secret: otp,
      );
      log('session: ${session.userId}');
      final user = await getCurrentSessionUser();

      await insertOrUpdateUser(user);
      await AppPrefHelper.setUserID(user.$id);
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> insertOrUpdateUser(User user) async {
    try {
      final documents = await _database.listDocuments(
        databaseId: AppWriteClient.databaseId,
        collectionId: AppWriteClient.userCollectionId,
        queries: [
          Query.equal(r'$id', user.$id),
        ],
      );

      if (documents.total > 0) {
        await _userRepository.updateUser();
      } else {
        await _userRepository.insertUser();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _account.deleteSession(sessionId: 'current');
      await AppPref.clear();
    } catch (e) {
      throw Exception(e);
    }
  }
}
