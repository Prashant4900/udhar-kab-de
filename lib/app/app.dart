import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/routes/route_manager.dart';
import 'package:mobile/utils/extensions.dart';
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
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF5F6FB),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF030065),
            primary: const Color(0xFF030065),
          ),
          appBarTheme: AppBarTheme(
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: false,
            backgroundColor: const Color(0xFFF5F6FB),
            foregroundColor: const Color(0xff000000),
            titleTextStyle: context.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xff000000),
            ),
          ),
          cardTheme: const CardTheme(
            elevation: 0,
            color: Color(0xFFFFFFFF),
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
        ),
        initialRoute: MyRoutes.splashScreen,
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );
  }
}
