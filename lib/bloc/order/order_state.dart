part of 'order_bloc.dart'; // Make sure to include the correct file name

enum OrderStatus { loading, success, failed }

class OrderState extends Equatable {
  final List<Order>? result;
  final Order? order;
  final List<Order>? orderById;
  final String? errorMessage;
  final OrderStatus orderStatus;

  const OrderState({
    this.result,
    this.order,
    this.orderById,
    this.errorMessage,
    this.orderStatus = OrderStatus.loading,
  });

  OrderState copyWith({
    List<Order>? result,
    Order? order,
    List<Order>? orderById,
    String? errorMessage,
    OrderStatus? orderStatus,
  }) {
    return OrderState(
      result: result ?? this.result,
      order: order ?? this.order,
      orderById: orderById ?? this.orderById,
      errorMessage: errorMessage ?? this.errorMessage,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }

  @override
  List<Object?> get props =>
      [result, order, orderById, errorMessage, orderStatus];
}
