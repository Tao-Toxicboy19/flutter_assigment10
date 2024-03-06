// ignore_for_file: prefer_const_constructors

import 'package:flutter_assigment10v1/screens/bottomnav/dashboard_screen.dart';
import 'package:flutter_assigment10v1/screens/login_screen.dart';
import 'package:flutter_assigment10v1/screens/register_screen.dart';

class AppRouter {
  static const String login = 'login';
  static const String register = 'register';
  static const String dashboard = 'dashboard';

  static get routes => {
        login: (context) => LoginScreen(),
        register: (context) => RegisterScreen(),
        dashboard: (context) => DashboardScreen(),
      };
}
