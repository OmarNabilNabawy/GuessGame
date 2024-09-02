import 'package:flutter/material.dart';
import 'package:guess/constants.dart';
import 'package:guess/features/auth_feature/presentation/views/login_view.dart';
import 'package:guess/features/game_feature/presentation/views/enter_number_view.dart';
import 'package:guess/features/game_feature/presentation/views/game_view.dart';
import 'package:guess/features/game_feature/presentation/views/win_view.dart';

import '../features/auth_feature/presentation/views/register_view.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  registerViewRoute: (context) => const RegisterView(),
  loginViewRoute: (context) => const LoginView(),
  gameViewRoute: (context) => const GameView(),
  enterNumberViewRoute: (context) => const EnterNumberView(),
  winViewRoute: (context) => const WinView(),
};
