import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:mobile/service/app_client.dart';
import 'package:mobile/utilities/share_pref/app_prefs.dart';

class AuthRepository {
  final _account = AppWriteClient.account;
  final _database = AppWriteClient.database;

  Future<User> signInWithGoogle() async {
    try {
      await _account.createOAuth2Session(provider: 'google');
      final user = await _account.get();
      log('username: ${user.name}, email: ${user.email}, id: ${user.$id}');
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

  Future<String> validateOTP(String userId, String otp) async {
    try {
      final session = await _account.updatePhoneSession(
        userId: userId,
        secret: otp,
      );
      log('session: ${session.countryName}');
      await insertUser('user');

      return session.userId;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> insertUser(String atr) async {
    try {
      final result = await _database.createDocument(
        databaseId: '65a43508726d50a4e9ea',
        collectionId: '65a43518a7b432418732',
        documentId: ID.unique(),
        data: {
          'email': atr,
          // 'name': user.name,
          // 'phone': user.phone,
          // 'user-id': user.$id,
          // 'create-at': user.$createdAt,
          // 'update-at': user.$updatedAt,
        },
      );
      if (result.$collectionId != '') {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _account.deleteSession(sessionId: 'current');
      await AppPrefHelper.deleteUserID();
    } catch (e) {
      throw Exception(e);
    }
  }
}
