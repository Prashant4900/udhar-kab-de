import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mobile/app/app.dart';
import 'package:mobile/setup.dart';
import 'package:mobile/utilities/share_pref/app_prefs.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await AppPref.init();
  await setup();
  runApp(const MyApp());
  // await runZonedGuarded(
  //   () async {

  //   },
  //   (error, stack) {
  //     log('Some Error Occur at main function: $error');
  //   },
  // );
}
