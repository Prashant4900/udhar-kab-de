import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mobile/routes/route_manager.dart';
import 'package:mobile/theme/theme_manager.dart';
import 'package:mobile/views/auth/bloc/auth_bloc.dart';
import 'package:mobile/views/hotspots/provider/hotspot_type_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider<HotspotTypeProvider>(
          create: (context) => HotspotTypeProvider(),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc()..add(UserStatusEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Udhar Kab Dega',
        debugShowCheckedModeBanner: false,
        theme: ThemeManager.lightTheme,
        initialRoute: MyRoutes.splashScreen,
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );
  }
}
