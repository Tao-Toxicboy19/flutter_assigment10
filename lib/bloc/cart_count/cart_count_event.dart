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

class CartAddEvent extends CartCountEvent {
  final String id;
  const CartAddEvent(this.id);
}

class CartRemoveEvent extends CartCountEvent {
  final String id;
  const CartRemoveEvent(this.id);
}

class FetchCountsEvent extends CartCountEvent {}
