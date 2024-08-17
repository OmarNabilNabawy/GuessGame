import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guess/constants.dart';
import 'package:guess/core/app_routes.dart';
import 'package:guess/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GuessGame());
}

class GuessGame extends StatelessWidget {
  const GuessGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
      initialRoute: loginViewRoute,
    );
  }
}
