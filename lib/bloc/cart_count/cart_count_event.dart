part of 'cart_count_bloc.dart';

sealed class CartCountEvent extends Equatable {
  const CartCountEvent();

  @override
  List<Object> get props => [];
}

class CartCountsEvent extends CartCountEvent {
  final Order order;
  const CartCountsEvent(this.order);
}

class FetchCountsEvent extends CartCountEvent {}
