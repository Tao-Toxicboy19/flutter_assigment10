part of 'cart_count_bloc.dart';

sealed class CartCountEvent extends Equatable {
  const CartCountEvent();

  @override
  List<Object> get props => [];
}

class CartCountsEvent extends CartCountEvent {}