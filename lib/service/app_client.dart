import 'package:appwrite/appwrite.dart';

class AppWriteClient {
  AppWriteClient._();

  static final _client = Client()
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('65a2acbe127ba5888572')
      .setSelfSigned();

  static final database = Databases(_client);

  static final account = Account(_client);

  static const databaseId = '65a43508726d50a4e9ea';

  static const userCollectionId = '65a43518a7b432418732';

  static const hotspotCollectionId = '65a8fe72c7e5968b8031';
}
