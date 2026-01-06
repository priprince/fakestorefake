import 'package:fakestorefake/dependency/get_it.dart';
import 'package:fakestorefake/routes/router.dart';
import 'package:flutter/material.dart';

void main() async {
  await setupDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const LoginPage(),
    );
  }
}
