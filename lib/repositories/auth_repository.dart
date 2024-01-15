import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:mobile/service/app_client.dart';

class AuthRepository {
  final account = Account(AppWriteClient.client);

  Future<User> signInWithGoogle() async {
    try {
      await account.createOAuth2Session(
        provider: 'google',
      );
      final user = await account.get();
      await insertUser(user);
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> initiatePhoneAuth(String phone) async {
    try {
      final sessionToken = await account.createPhoneSession(
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
      final session = await account.updatePhoneSession(
        userId: userId,
        secret: otp,
      );
      log('session: ${session.countryName}');
      return session.userId;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> insertUser(User user) async {
    try {
      //TODO: Insert User into Database Collection
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    try {
      await account.deleteSession(sessionId: 'current');
    } catch (e) {
      throw Exception(e);
    }
  }
}
