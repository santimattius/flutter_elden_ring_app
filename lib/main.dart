import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_elden_ring_app/features/bosses/presentation/pages/bosses_page.dart';
import 'package:flutter_elden_ring_app/features/splash/splash_page.dart';

import 'injection_container.dart' as di;

class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new CustomHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(FlutterAppTemplate());
}

const _APP_NAME = 'Elden Ring';

class FlutterAppTemplate extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp();
  }

  // create android app
  MaterialApp buildMaterialApp() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _APP_NAME,
      routes: {
        "splash": (context) => SplashPage(),
        "home": (context) => BossesPage(),
      },
      initialRoute: "home",
      theme: ThemeData(primarySwatch: Colors.blueGrey, useMaterial3: true),
    );
  }
}
