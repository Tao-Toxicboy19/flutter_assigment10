// ignore_for_file: unnecessary_import, depend_on_referenced_packages, unrelated_type_equality_checks, use_build_context_synchronously

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/bloc/order/order_bloc.dart';
import 'package:flutter_assigment10v1/main.dart';
import 'package:flutter_assigment10v1/models/order_model.dart';
import 'package:flutter_assigment10v1/services/dio_config.dart';
import 'package:flutter_assigment10v1/utils/logger.dart';
import 'package:flutter_assigment10v1/utils/network_connect.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';

part 'order_me_event.dart';
part 'order_me_state.dart';

class OrderMeBloc extends Bloc<OrderMeEvent, OrderMeState> {
  OrderMeBloc() : super(const OrderMeState()) {
    on<AddOrderMeEvent>(
      (event, emit) async {
        try {
          final NetworkConnect newNetworkConnect = NetworkConnect();
          final Dio dio = DioConfig.dioWithAuth;

          if (newNetworkConnect.checkNetwork() == '') {
            emit(const OrderMeState(
                oderMeStatus: OrderMeStatus.failed,
                errorMessage: 'No network is connected'));
          }

          FormData data = FormData.fromMap({
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
              // add(FetchOrdersEvent);
              navigatorState.currentContext!
                  .read<OrderBloc>()
                  .add(FetchOrdersEvent());
              add(FetchOrderByUserIdEvent(event.payload.userId!));
            }
            // emit(const OrderState(orderStatus: OrderStatus.success));
          } else {
            // Handle non-200 status code as an error
            logger.e('Error: ${result.statusCode}');
            emit(const OrderMeState(oderMeStatus: OrderMeStatus.failed));
          }
        } catch (err) {
          // Handle other errors (e.g., network error, parsing error)
          logger.e('Error: $err');
          emit(const OrderMeState(oderMeStatus: OrderMeStatus.failed));
        }
      },
    );

    on<FetchOrderByUserIdEvent>(
      (event, emit) async {
        try {
          final NetworkConnect newNetworkConnect = NetworkConnect();
          final Dio dio = DioConfig.dioWithAuth;

          if (newNetworkConnect.checkNetwork() == '') {
            emit(const OrderMeState(
                oderMeStatus: OrderMeStatus.failed,
                errorMessage: 'No network is connected'));
          }

          final result = await dio.get('user/orders/${event.userId}');
          final List<Order> orders = List<Order>.from(
            (result.data as List).map((item) => Order.fromJson(item)),
          );
          emit(OrderMeState(
              oderMeStatus: OrderMeStatus.success, orderById: orders));
        } catch (err) {
          // Handle other errors (e.g., network error, parsing error)
          logger.e('Error: $err');
          emit(const OrderMeState(oderMeStatus: OrderMeStatus.failed));
        }
      },
    );

    on<OrderMeUpdateEvent>(
      (event, emit) async {
        try {
          final NetworkConnect newNetworkConnect = NetworkConnect();
          final Dio dio = DioConfig.dioWithAuth;

          if (newNetworkConnect.checkNetwork() == '') {
            emit(const OrderMeState(
                oderMeStatus: OrderMeStatus.failed,
                errorMessage: 'No network is connected'));
          }

          FormData data = FormData.fromMap({
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
          final result = await dio.put('order/${event.id}', data: data);
          if (result.statusCode == 201) {
            if (navigatorState.currentContext != null) {
              Navigator.pop(navigatorState.currentContext!, true);
              navigatorState.currentContext!
                  .read<OrderBloc>()
                  .add(FetchOrdersEvent());
              add(FetchOrderByUserIdEvent(event.payload.userId!));
            }
            emit(const OrderMeState(oderMeStatus: OrderMeStatus.success));
          } else {
            // Handle non-200 status code as an error
            logger.e('Error: ${result.statusCode}');
            emit(const OrderMeState(oderMeStatus: OrderMeStatus.failed));
          }
          // emit(const OrderMeState(oderMeStatus: OrderMeStatus.success));
        } catch (err) {
          // Handle other errors (e.g., network error, parsing error)
          logger.e('Error: $err');
          emit(const OrderMeState(oderMeStatus: OrderMeStatus.failed));
        }
      },
    );

    on<OrderMeDeleteEvent>(
      (event, emit) async {
        try {
          final NetworkConnect newNetworkConnect = NetworkConnect();
          final Dio dio = DioConfig.dioWithAuth;

          if (newNetworkConnect.checkNetwork() == '') {
            emit(const OrderMeState(
                oderMeStatus: OrderMeStatus.failed,
                errorMessage: 'No network is connected'));
          }
          logger.d("order id: ${event.id}");
          final result = await dio.delete('order/${event.id}');
          logger.f(result);
          if (result.statusCode == 200) {
            if (navigatorState.currentContext != null) {
              Navigator.pop(navigatorState.currentContext!, true);
              navigatorState.currentContext!
                  .read<OrderBloc>()
                  .add(FetchOrdersEvent());
              add(FetchOrderByUserIdEvent(event.userId));
            }
            emit(const OrderMeState(oderMeStatus: OrderMeStatus.success));
          } else {
            // Handle non-200 status code as an error
            logger.e('Error: ${result.statusCode}');
            emit(const OrderMeState(oderMeStatus: OrderMeStatus.failed));
          }
          emit(const OrderMeState(oderMeStatus: OrderMeStatus.success));
        } catch (err) {
          // Handle other errors (e.g., network error, parsing error)
          logger.e('Error: $err');
          emit(const OrderMeState(oderMeStatus: OrderMeStatus.failed));
        }
      },
    );
  }
}
