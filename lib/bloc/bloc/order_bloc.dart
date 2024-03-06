// ignore_for_file: unrelated_type_equality_checks

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_assigment10v1/models/order_model.dart';
import 'package:flutter_assigment10v1/services/dio_config.dart';
import 'package:flutter_assigment10v1/utils/logger.dart';
import 'package:flutter_assigment10v1/utils/network_connect.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const OrderState()) {
    on<OrderEvent>((event, emit) async {
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
    });
  }
}
