import 'package:flutter/material.dart';
import 'package:guess_game/core/widgets/auth_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthView(
      viewName: 'LOGIN',
      haveAccount: 'dont\'t have an account?',
      logRegis: 'Register',
    );
  }
}
