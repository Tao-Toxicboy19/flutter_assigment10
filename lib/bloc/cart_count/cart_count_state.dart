part of 'cart_count_bloc.dart';

enum CartCountStatus { loading, success, failed }

class CartCountState extends Equatable {
  final int cartCount;
  final int productCount;
  final List<String> quantity;
  final List<Order>? cartOrder;
  final String? errorMessage;
  final CartCountStatus status;

  const CartCountState({
    this.cartOrder,
    this.cartCount = 0,
    this.productCount = 0,
    this.quantity = const [], // เปลี่ยนเป็นรายการว่างเปล่า
    this.errorMessage,
    this.status = CartCountStatus.loading,
  });

  CartCountState copyWith({
    List<Order>? cartOrder,
    int? cartCount,
    int? productCount,
    List<String>? quantity,
    String? errorMessage,
    CartCountStatus? status,
  }) {
    return CartCountState(
      cartOrder: cartOrder ?? this.cartOrder,
      cartCount: cartCount ?? this.cartCount,
      productCount: productCount ?? this.productCount,
      quantity: quantity ?? this.quantity,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        cartCount,
        quantity,
        productCount,
        cartOrder,
        errorMessage,
        CartCountStatus
      ];
}
