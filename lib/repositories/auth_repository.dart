import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:mobile/service/app_client.dart';
import 'package:mobile/utilities/share_pref/app_prefs.dart';

class AuthRepository {
  final _account = AppWriteClient.account;
  final _database = AppWriteClient.database;

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
      // await insertOrUpdateUser(user);
      await AppPrefHelper.setUserID(user.$id);
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> getUserPref(AppPrefKey key) async {
    try {
      final result = await _account.getPrefs();
      log('result: ${result.data['afs']}');
      final value = result.data[key.name];
      if (value != null) {
        return value;
      }
      throw Exception('Value not found!');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setUserPref(Map<dynamic, dynamic> prefs) async {
    try {
      await _account.updatePrefs(prefs: prefs);
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
      log('session: ${session.userId}');
      final user = await getCurrentSessionUser();
      await insertOrUpdateUser(user);
      await AppPrefHelper.setUserID(user.$id);
      return session.userId;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> insertOrUpdateUser(User user) async {
    try {
      Document result;

      final documents = await _database.listDocuments(
        databaseId: '65a43508726d50a4e9ea',
        collectionId: '65a43518a7b432418732',
        queries: [
          Query.equal('userId', user.$id),
        ],
      );

      if (documents.total > 0) {
        final documentID = documents.documents.first.$id;

        result = await _database.updateDocument(
          databaseId: '65a43508726d50a4e9ea',
          collectionId: '65a43518a7b432418732',
          documentId: documentID,
          data: {
            'userId': user.$id,
            'name': user.name.isEmpty ? null : user.name,
            'phone': user.phone.isEmpty ? null : user.phone,
            'phoneVerification': user.phoneVerification,
            'email': user.email.isEmpty ? null : user.email,
            'emailVerification': user.emailVerification,
            'status': user.status,
            'updateAt': user.$updatedAt,
            'createAt': user.$createdAt,
            'registrationDate': user.registration,
            'accessedAt': user.accessedAt,
            'passwordUpdate': user.passwordUpdate,
            'hotspot': [
              {
                'hostpotName': 'hostpot1Name',
                'hotspotLocation': 'hots1potLocation',
                'hotspotType': 'hotspotTy1pe',
              },
            ],
          },
        );
      } else {
        result = await _database.createDocument(
          databaseId: '65a43508726d50a4e9ea',
          collectionId: '65a43518a7b432418732',
          documentId: ID.unique(),
          data: {
            'userId': user.$id,
            'name': user.name.isEmpty ? null : user.name,
            'phone': user.phone.isEmpty ? null : user.phone,
            'phoneVerification': user.phoneVerification,
            'email': user.email.isEmpty ? null : user.email,
            'emailVerification': user.emailVerification,
            'status': user.status,
            'updateAt': user.$updatedAt,
            'createAt': user.$createdAt,
            'registrationDate': user.registration,
            'accessedAt': user.accessedAt,
            'passwordUpdate': user.passwordUpdate,
            'hotspot': [
              {
                'hostpotName': 'hostpotName1',
                'hotspotLocation': 'hotspotL1ocation',
                'hotspotType': 'hotspotType1',
              },
            ],
          },
        );
      }

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
      await AppPref.clear();
      //await AppPrefHelper.deleteUserID();
    } catch (e) {
      throw Exception(e);
    }
  }
}
