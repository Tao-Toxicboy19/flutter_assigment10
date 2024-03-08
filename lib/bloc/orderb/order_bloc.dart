// ignore_for_file: unrelated_type_equality_checks
import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/main.dart';
import 'package:flutter_assigment10v1/models/order_model.dart';
import 'package:flutter_assigment10v1/services/dio_config.dart';
import 'package:flutter_assigment10v1/utils/logger.dart';
import 'package:flutter_assigment10v1/utils/network_connect.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const OrderState()) {
    on<FetchOrdersEvent>(
      (event, emit) async {
        try {
          final NetworkConnect newNetworkConnect = NetworkConnect();
          final Dio dio = DioConfig.dioWithAuth;

          if (newNetworkConnect.checkNetwork() == '') {
            emit(const OrderState(
                orderStatus: OrderStatus.failed,
                errorMessage: 'No network is connected'));
          }

          final result = await dio.get('order');
          final List<Order> orders = List<Order>.from(
            (result.data as List).map((item) => Order.fromJson(item)),
          );

          emit(OrderState(orderStatus: OrderStatus.success, result: orders));
        } catch (err) {
          // Handle other errors (e.g., network error, parsing error)
          logger.e('Error: $err');
          emit(const OrderState(orderStatus: OrderStatus.failed));
        }
      },
    );

    on<AddOrderEvent>(
      (event, emit) async {
        try {
          final NetworkConnect newNetworkConnect = NetworkConnect();
          final Dio dio = DioConfig.dioWithAuth;

          if (newNetworkConnect.checkNetwork() == '') {
            emit(const OrderState(
                orderStatus: OrderStatus.failed,
                errorMessage: 'No network is connected'));
          }

          FormData data = FormData.fromMap({
            "id": "1223",
            "beerName": event.payload.beerName,
            "description": event.payload.description,
            "Alcohol": event.payload.alcohol,
            "price": event.payload.price,
            "stock": event.payload.stock,
            "ShopName": event.payload.shopName,
            "UserId": event.payload.userId,
            if (event.file != null)
              "files": await MultipartFile.fromFile(
                event.file!.path,
                contentType: MediaType("image", "jpg"),
              ),
          });
          // logger.d(data);
          final result = await dio.post('order', data: data);
          if (result.statusCode == 200) {
            if (navigatorState.currentContext != null) {
              Navigator.pop(navigatorState.currentContext!, true);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                add(FetchOrdersEvent());
              });
            }
          } else {
            // Handle non-200 status code as an error
            logger.e('Error: ${result.statusCode}');
            emit(const OrderState(orderStatus: OrderStatus.failed));
          }
        } catch (err) {
          // Handle other errors (e.g., network error, parsing error)
          logger.e('Error: $err');
          emit(const OrderState(orderStatus: OrderStatus.failed));
        }
      },
    );

    on<FetchOrderByUserIdEvent>(
      (event, emit) async {
        try {
          final NetworkConnect newNetworkConnect = NetworkConnect();
          final Dio dio = DioConfig.dioWithAuth;

          if (newNetworkConnect.checkNetwork() == '') {
            emit(const OrderState(
                orderStatus: OrderStatus.failed,
                errorMessage: 'No network is connected'));
          }

          final result = await dio.get('user/orders/${event.userId}');
          final List<Order> orders = List<Order>.from(
            (result.data as List).map((item) => Order.fromJson(item)),
          );
          logger.i(result.data);
          emit(OrderState(orderStatus: OrderStatus.success, orderById: orders));
        } catch (err) {
          // Handle other errors (e.g., network error, parsing error)
          logger.e('Error: $err');
          emit(const OrderState(orderStatus: OrderStatus.failed));
        }
      },
    );
  }
}
