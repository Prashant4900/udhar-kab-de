import 'package:appwrite/appwrite.dart';

class AppWriteClient {
  AppWriteClient._();

  static final client = Client()
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('65a2acbe127ba5888572')
      .setSelfSigned();
}
