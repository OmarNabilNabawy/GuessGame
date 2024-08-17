import 'package:flutter/material.dart';
import 'package:guess/core/widgets/auth_view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthView(
      viewName: 'REGISTER',
      haveAccount: 'already have an account?',
      logRegis: 'Login',
    );
  }
}
