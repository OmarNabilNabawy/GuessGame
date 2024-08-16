import 'package:flutter/material.dart';
import 'package:guess_game/constants.dart';
import 'package:guess_game/core/app_routes.dart';

void main() {
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
