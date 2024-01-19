import 'package:appwrite/appwrite.dart';
import 'package:mobile/models/hotspots/hotspot_request_model.dart';
import 'package:mobile/models/hotspots/hotspot_response_model.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/repositories/user_repository.dart';
import 'package:mobile/service/app_client.dart';
import 'package:mobile/setup.dart';

class HotspotRepository {
  final _database = AppWriteClient.database;
  final _account = AppWriteClient.account;
  final userRepository = getIt<UserRepository>();

  Future<HotspotResponseModel> createHotspot(
    HotspotRequestModel hotspotModel,
  ) async {
    try {
      final user = await _account.get();

      final result = await _database.createDocument(
        databaseId: AppWriteClient.databaseId,
        collectionId: AppWriteClient.hotspotCollectionId,
        documentId: ID.unique(),
        data: hotspotModel.copyWith(userID: user.$id).toMap(),
      );

      return HotspotResponseModel.fromMap(result.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<HotspotResponseModel>?> getHotspots() async {
    try {
      final user = await userRepository.getUserData();
      final userModel = UserModel.fromMap(user.toMap());

      return userModel.hotspot;
    } on AppwriteException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteHotspots(HotspotRequestModel model) async {
    try {
      await _database.deleteDocument(
        databaseId: AppWriteClient.databaseId,
        collectionId: AppWriteClient.hotspotCollectionId,
        documentId: model.id!,
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
