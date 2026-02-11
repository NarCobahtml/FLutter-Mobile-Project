import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'splash_screen.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    final full = details.toString(); // includes stack
    return Material(
      color: Colors.red,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Text(
            full,
            style: const TextStyle(color: Colors.yellow, fontSize: 12),
          ),
        ),
      ),
    );
  };

  runZonedGuarded(
    () {
      runApp(const MyApp());
    },
    (error, stack) {
      // ignore: avoid_print
      print('Uncaught zone error:');
      // ignore: avoid_print
      print(error);
      // ignore: avoid_print
      print(stack);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Learning App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFF110E33),
        fontFamily: 'PlusJakarta',
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: const SplashScreenSvg(),
    );
  }
}
