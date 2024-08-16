import 'package:flutter/material.dart';
import 'package:guess_game/constants.dart';
import 'package:guess_game/features/auth_feature/presentation/views/login_view.dart';

import '../features/auth_feature/presentation/views/register_view.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  registerViewRoute: (context) => const RegisterView(),
  loginViewRoute: (context) => const LoginView(),
};
