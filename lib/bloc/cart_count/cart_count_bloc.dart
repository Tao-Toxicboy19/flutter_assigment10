// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_assigment10v1/models/order_model.dart';
import 'package:flutter_assigment10v1/utils/logger.dart';

part 'cart_count_event.dart';
part 'cart_count_state.dart';

class CartCountBloc extends Bloc<CartCountEvent, CartCountState> {
  CartCountBloc() : super(const CartCountState()) {
    on<CartCountsEvent>(
      (event, emit) {
        final List<Order> orders = List<Order>.from(state.cartOrder ?? []);

        // ตรวจสอบว่า event.order ยังไม่มีอยู่ในรายการ
        if (!orders.contains(event.order)) {
          orders.add(event.order);

          // ดึง Order ID จาก event.order และเพิ่มเข้าไปใน quantity
          final String orderID =
              event.order.id ?? ''; // ดักเพื่อไม่ให้เกิด Null Exception
          final List<String> updatedQuantity =
              List<String>.from(state.quantity ?? []);
          updatedQuantity.add(orderID);

          emit(
            state.copyWith(
              cartCount: state.cartCount + 1,
              cartOrder: orders,
              productCount: state.productCount + 1,
              quantity: updatedQuantity,
            ),
          );
        } else {
          emit(
            state.copyWith(
              productCount: state.productCount + 1,
              quantity: state.quantity,
            ),
          );
        }
      },
    );

    on<FetchCountsEvent>(
      (event, emit) {
        logger.t("OK");
        emit(state.copyWith(status: CartCountStatus.success));
      },
    );
  }
}
