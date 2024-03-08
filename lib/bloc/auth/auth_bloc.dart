// ignore_for_file: unrelated_type_equality_checks

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/app_routes.dart';
import 'package:flutter_assigment10v1/main.dart';
import 'package:flutter_assigment10v1/models/me_model.dart';
import 'package:flutter_assigment10v1/models/user_model.dart';
import 'package:flutter_assigment10v1/services/dio_config.dart';
import 'package:flutter_assigment10v1/utils/constants.dart';
import 'package:flutter_assigment10v1/utils/logger.dart';
import 'package:flutter_assigment10v1/utils/network_connect.dart';
import 'package:flutter_assigment10v1/utils/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<LoginEvent>(
      (event, emit) async {
        try {
          final NetworkConnect newNetworkConnect = NetworkConnect();
          final Dio dio = DioConfig.dio;

          if (newNetworkConnect.checkNetwork() == '') {
            emit(const AuthState(
                authStatus: AuthStatus.failed,
                errorMessage: 'No network is connected'));
            return;
          }
          final value = {
            "username": event.payload.username,
            "password": event.payload.password,
          };

          final result = await dio.post('signin', data: value);

          await MySharedPreferences.setSharedPreference(
            token,
            result.data["refresh_token"],
          );
          // Handle the response as needed
          if (result.statusCode == 200) {
            // ส่งสถานะ AuthStatus.success และทำการ navigation
            emit(const AuthState(authStatus: AuthStatus.success));

            // ทำการ navigation ไปที่หน้า OTP
            if (navigatorState.currentContext != null) {
              Navigator.pushNamedAndRemoveUntil(
                navigatorState.currentContext!,
                AppRouter.product,
                (route) => false, // ลบทุกหน้าออกจาก stack
              );
            }
          } else {
            // Handle non-200 status code as an error
            logger.e('Error: ${result.statusCode}');
            emit(const AuthState(authStatus: AuthStatus.failed));
          }
        } catch (err) {
          // Handle other errors (e.g., network error, parsing error)
          logger.e('Error: $err');
          emit(const AuthState(authStatus: AuthStatus.failed));
        }
      },
    );

    on<RegisterEvent>(
      (event, emit) async {
        try {
          final NetworkConnect newNetworkConnect = NetworkConnect();
          final Dio dio = DioConfig.dio;

          if (newNetworkConnect.checkNetwork() == '') {
            emit(const AuthState(
                authStatus: AuthStatus.failed,
                errorMessage: 'No network is connected'));
            return;
          }

          final value = {
            "username": event.payload.username,
            "password": event.payload.password,
            "email": event.payload.email,
            "shopname": event.payload.shopName,
          };

          final result = await dio.post('signup', data: value);

          // Handle the response as needed
          if (result.statusCode == 201) {
            // ส่งสถานะ AuthStatus.success และทำการ navigation
            emit(const AuthState(authStatus: AuthStatus.success));

            // ทำการ navigation ไปที่หน้า OTP
            if (navigatorState.currentContext != null) {
              Navigator.pushReplacementNamed(
                navigatorState.currentContext!,
                AppRouter.login,
              );
            }
          } else {
            // Handle non-200 status code as an error
            logger.e('Error: ${result.statusCode}');
            emit(const AuthState(authStatus: AuthStatus.failed));
          }
        } catch (err) {
          // Handle other errors (e.g., network error, parsing error)
          logger.e('Error: $err');
          emit(const AuthState(authStatus: AuthStatus.failed));
        }
      },
    );

    on<MeEvent>(
      (event, emit) async {
        try {
          final NetworkConnect newNetworkConnect = NetworkConnect();
          final Dio dio = DioConfig.dioWithAuth;

          if (newNetworkConnect.checkNetwork() == '') {
            emit(const AuthState(
                authStatus: AuthStatus.failed,
                errorMessage: 'No network is connected'));
            return;
          }

          final result = await dio.get('auth/me');

          // Handle the response as needed
          if (result.statusCode == 200) {
            // ส่งสถานะ AuthStatus.success และทำการ navigation
            final Me me = Me.fromJson(result.data);
            logger.f(result.data);
            emit(AuthState(
              authStatus: AuthStatus.success,
              me: me,
            ));
          } else {
            // Handle non-200 status code as an error
            logger.e('Error: ${result.statusCode}');
            emit(const AuthState(authStatus: AuthStatus.failed));
          }
        } catch (err) {
          // Handle other errors (e.g., network error, parsing error)
          logger.e('Error: $err');
          emit(const AuthState(authStatus: AuthStatus.failed));
        }
      },
    );
  }
}
