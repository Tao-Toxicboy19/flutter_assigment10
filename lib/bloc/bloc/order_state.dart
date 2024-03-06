part of 'order_bloc.dart';

enum OrderStatus { loading, success, failed }

class OrderState extends Equatable {
  final List<Order>? result;
  final String? errorMessage;
  final OrderStatus orderStatus;

  const OrderState({
    this.result,
    this.errorMessage,
    this.orderStatus = OrderStatus.loading,
  });

  OrderState copyWith({
    List<Order>? result,
    String? errorMessage,
    OrderStatus? orderStatus,
  }) {
    return OrderState(
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }

  @override
  List<Object?> get props => [result, errorMessage, orderStatus];
}
