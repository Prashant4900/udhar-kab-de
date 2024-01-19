import 'package:get_it/get_it.dart';
import 'package:mobile/repositories/auth_repository.dart';
import 'package:mobile/repositories/hotspot_repository.dart';
import 'package:mobile/repositories/user_repository.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt
    ..registerSingleton<AuthRepository>(AuthRepository())
    ..registerSingleton<UserRepository>(UserRepository())
    ..registerSingleton<HotspotRepository>(HotspotRepository());
}
