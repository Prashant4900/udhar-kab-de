import 'package:appwrite/appwrite.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/service/app_client.dart';

class UserRepository {
  final _account = AppWriteClient.account;
  final _database = AppWriteClient.database;

  Future<UserModel> getUserData() async {
    try {
      final user = await _account.get();

      final userDoc = await _database.getDocument(
        databaseId: AppWriteClient.databaseId,
        collectionId: AppWriteClient.userCollectionId,
        documentId: user.$id,
      );

      final result = UserModel.fromMap(userDoc.data);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> insertUser() async {
    try {
      final user = await _account.get();
      final model = UserModel.fromMap(user.toMap());
      final document = await _database.createDocument(
        databaseId: AppWriteClient.databaseId,
        collectionId: AppWriteClient.userCollectionId,
        documentId: ID.custom(user.$id),
        data: model.toMap(),
      );

      return UserModel.fromMap(document.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> updateUser() async {
    try {
      final user = await _account.get();
      final model = UserModel.fromMap(user.toMap());

      final document = await _database.updateDocument(
        databaseId: AppWriteClient.databaseId,
        collectionId: AppWriteClient.userCollectionId,
        documentId: user.$id,
        data: model.toMap(),
      );

      return UserModel.fromMap(document.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteUserData(String userID) async {
    try {
      await _database.deleteDocument(
        databaseId: AppWriteClient.databaseId,
        collectionId: AppWriteClient.userCollectionId,
        documentId: userID,
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
