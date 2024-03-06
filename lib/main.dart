// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/app_routes.dart';
import 'package:flutter_assigment10v1/bloc/auth/auth_bloc.dart';
import 'package:flutter_assigment10v1/bloc/bloc/order_bloc.dart';
import 'package:flutter_assigment10v1/utils/constants.dart';
import 'package:flutter_assigment10v1/utils/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var initiaRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MySharedPreferences.initSharedPrefs();

  if (MySharedPreferences.getSharedPreference(token) != null) {
    initiaRoute = AppRouter.dashboard;
  } else {
    initiaRoute = AppRouter.login;
  }

  runApp(const MyApp());
}

final navigatorState = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider(create: (context) => AuthBloc());
    final orderBloc = BlocProvider(create: (context) => OrderBloc());

    return MultiBlocProvider(
      providers: [
        authBloc,
        orderBloc,
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: initiaRoute,
        routes: AppRouter.routes,
        navigatorKey: navigatorState,
      ),
    );
  }
}
