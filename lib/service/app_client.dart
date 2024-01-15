import 'package:appwrite/appwrite.dart';

class AppWriteClient {
  AppWriteClient._();

  static final _client = Client()
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('65a2acbe127ba5888572')
      .setSelfSigned();

  static final database = Databases(_client);

  static final account = Account(_client);
}
