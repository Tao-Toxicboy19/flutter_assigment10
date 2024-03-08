// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_assigment10v1/models/order_model.dart';

part 'cart_count_event.dart';
part 'cart_count_state.dart';

class CartCountBloc extends Bloc<CartCountEvent, CartCountState> {
  CartCountBloc() : super(const CartCountState()) {
    on<CartCountsEvent>((event, emit) {
      emit(state.copyWith(cartCount: state.cartCount + 1));
    });
  }
}
