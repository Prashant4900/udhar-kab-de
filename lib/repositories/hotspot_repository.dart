import 'package:appwrite/appwrite.dart';
import 'package:mobile/models/hotspot_model.dart';
import 'package:mobile/service/app_client.dart';

// ignore: camel_case_types
class HotspotRepository {
  final _database = AppWriteClient.database;

  Future<void> createHotspot(HotspotModel hotspotModel) async {
    try {
      final document = await _database.createDocument(
        databaseId: AppWriteClient.databaseId,
        collectionId: AppWriteClient.hotspotCollectionId,
        documentId: ID.unique(),
        data: hotspotModel.toJson(),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getHotspots() async {
    try {
      await _database.listDocuments(
        databaseId: AppWriteClient.databaseId,
        collectionId: AppWriteClient.hotspotCollectionId,
      );
    } on AppwriteException catch (e) {
      throw Exception(e);
    }
  }
}
