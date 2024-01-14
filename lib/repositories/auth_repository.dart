import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:mobile/service/app_client.dart';

class AuthRepository {
  final account = Account(AppWriteClient.client);

  Future<User> signInWithGoogle() async {
    try {
      final result = await account.createOAuth2Session(
        provider: 'google',
      );
      print('result: $result');
      final user = await account.get();
      return user;
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
