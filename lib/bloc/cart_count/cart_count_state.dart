part of 'cart_count_bloc.dart';

enum CartCountStatus { loading, success, failed }

class CartCountState extends Equatable {
  final int cartCount;
  final List<Order>? cartOrder;
  final String? errorMessage;
  final CartCountStatus status;

  const CartCountState({
    this.cartOrder,
    this.cartCount = 0,
    this.errorMessage,
    this.status = CartCountStatus.loading,
  });

  CartCountState copyWith({
    List<Order>? cartOrder,
    int? cartCount,
    String? errorMessage,
    CartCountStatus? status,
  }) {
    return CartCountState(
      cartOrder: cartOrder ?? this.cartOrder,
      cartCount: cartCount ?? this.cartCount,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props =>
      [cartCount, cartOrder, errorMessage, CartCountStatus];
}
