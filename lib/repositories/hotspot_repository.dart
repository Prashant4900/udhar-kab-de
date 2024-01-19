import 'package:appwrite/appwrite.dart';
import 'package:mobile/models/hotspot_model.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/repositories/user_repository.dart';
import 'package:mobile/service/app_client.dart';
import 'package:mobile/setup.dart';

// ignore: camel_case_types
class HotspotRepository {
  final _database = AppWriteClient.database;
  final _account = AppWriteClient.account;
  final userRepository = getIt<UserRepository>();

  Future<void> createHotspot(HotspotModel hotspotModel) async {
    try {
      final user = await _account.get();

      await _database.createDocument(
        databaseId: AppWriteClient.databaseId,
        collectionId: AppWriteClient.hotspotCollectionId,
        documentId: ID.unique(),
        data: {
          'hotspotLocation': hotspotModel.hotspotLocation,
          'hotspotType': hotspotModel.hotspotType,
          'hotspotName': hotspotModel.hotspotName,
          'users': user.$id,
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<HotspotModel>?> getHotspots() async {
    try {
      final user = await userRepository.getUserData();
      final userModel = UserModel.fromMap(user.toMap());

      return userModel.hotspot;
    } on AppwriteException catch (e) {
      throw Exception(e);
    }
  }
}
