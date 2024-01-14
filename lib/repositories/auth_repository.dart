import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:mobile/service/app_client.dart';

class AuthRepository {
  final account = Account(AppWriteClient.client);

  Future<void> signInWithGoogle() async {
    try {
      final result = account.createOAuth2Session(
        provider: 'google',
        scopes: [
          'email',
          'profile',
          'phone',
        ],
      );
      await result.then((res) {
        log('response: $res');
      }).catchError((err) async {
        log('error: $err');
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
