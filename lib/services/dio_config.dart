// ignore_for_file: unused_local_variable, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_assigment10v1/utils/constants.dart';
import 'package:flutter_assigment10v1/utils/logger.dart';
import 'package:flutter_assigment10v1/utils/shared_preferences.dart';

class DioConfig {
  static late String _token;
  
  static _getToken() async {
    _token = await MySharedPreferences.getSharedPreference('token');
  }

  static final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Accept'] = 'application/json';
          options.headers['Content-Type'] = 'application/json';
          options.baseUrl = url;
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          return handler.next(response);
        },
        onError: (DioException err, handler) async {
          switch (err.response?.statusCode) {
            case 400:
              logger.e('Bad Request');
              break;
            case 401:
              logger.e('Unauthorized');
              break;
            case 403:
              logger.e('Forbidden');
              break;
            case 404:
              logger.e('Not Found');
              break;
            case 500:
              logger.e('Internal Server Error');
              break;
            default:
              logger.e('Something went wrong');
              break;
          }
          return handler.next(err);
        },
      ),
    );

  static final Dio _dioWithAuth = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          await _getToken();
          options.headers['Authorization'] = 'Bearer $_token';
          options.headers['Accept'] = 'application/json';
          options.headers['Content-Type'] = 'application/json';
          options.baseUrl = url;
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          switch (e.response?.statusCode) {
            case 400:
              logger.e('Bad Request');
              break;
            case 401:
              logger.e('Unauthorized');
              break;
            case 403:
              logger.e('Forbidden');
              break;
            case 404:
              logger.e('Not Found');
              break;
            case 500:
              logger.e('Internal Server Error');
              break;
            default:
              logger.e('Something went wrong');
              break;
          }
          return handler.next(e);
        },
      ),
    );
  static Dio get dio => _dio;
  static Dio get dioWithAuth => _dioWithAuth;
}
