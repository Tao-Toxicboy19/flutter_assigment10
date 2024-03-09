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

        // เพิ่ม id ของ order เข้าไปใน quantity
        final List<String> updatedQuantity = List<String>.from(state.quantity);
        updatedQuantity.add(event.order.id ?? '');

        // ตรวจสอบว่า event.order ยังไม่มีอยู่ในรายการ
        if (!orders.contains(event.order)) {
          orders.add(event.order);

          // นับจำนวน id ที่เหมือนกัน
          final Map<String, int> idCounts = {};
          for (var id in updatedQuantity) {
            idCounts[id] = (idCounts[id] ?? 0) + 1;
          }

          emit(
            state.copyWith(
              cartCount: state.cartCount + 1,
              cartOrder: orders,
              quantity: updatedQuantity,
              productCount: idCounts,
            ),
          );
        } else {
          // นับจำนวน id ที่เหมือนกัน
          final Map<String, int> idCounts = {};
          for (var id in updatedQuantity) {
            idCounts[id] = (idCounts[id] ?? 0) + 1;
          }

          emit(
            state.copyWith(
              quantity: updatedQuantity,
              productCount: idCounts,
            ),
          );
        }
      },
    );

    on<CartAddEvent>(
      (event, emit) {
        final List<String> updatedQuantity = List<String>.from(state.quantity);

        // ลบ 1 รายการที่มี id ที่ตรงกับ event.id จาก updatedQuantity
        updatedQuantity.add(event.id);

        // นับจำนวน id ที่เหมือนกัน
        final Map<String, int> idCounts = {};
        for (var id in updatedQuantity) {
          idCounts[id] = (idCounts[id] ?? 0) + 1;
        }

        emit(
          state.copyWith(
            status: CartCountStatus.success,
            quantity: updatedQuantity,
            productCount: idCounts,
          ),
        );
      },
    );

    on<CartRemoveEvent>(
      (event, emit) {
        final List<String> updatedQuantity = List<String>.from(state.quantity);

        // ลบ 1 รายการที่มี id ที่ตรงกับ event.id จาก updatedQuantity
        updatedQuantity.remove(event.id);

        // นับจำนวน id ที่เหมือนกัน
        final Map<String, int> idCounts = {};
        for (var id in updatedQuantity) {
          idCounts[id] = (idCounts[id] ?? 0) + 1;
        }

        emit(
          state.copyWith(
            status: CartCountStatus.success,
            quantity: updatedQuantity,
            productCount: idCounts,
          ),
        );
      },
    );

    on<FetchCountsEvent>(
      (event, emit) {
        logger.d("hello add");
        emit(state.copyWith(status: CartCountStatus.success));
      },
    );
  }
}
