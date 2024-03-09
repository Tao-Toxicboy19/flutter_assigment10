part of 'order_me_bloc.dart';

enum OrderMeStatus { loading, success, failed }

class OrderMeState extends Equatable {
  final Order? orders;
  final Order? order;
  final List<Order>? orderById;
  final String? errorMessage;
  final OrderMeStatus oderMeStatus;

  const OrderMeState({
    this.orders,
    this.order,
    this.orderById,
    this.errorMessage,
    this.oderMeStatus = OrderMeStatus.loading,
  });

  OrderMeState copyWith({
    Order? orders,
    Order? order,
    List<Order>? orderById,
    String? errorMessage,
    OrderMeStatus? oderMeStatus,
  }) {
    return OrderMeState(
      orders: orders ?? this.orders,
      order: order ?? this.order,
      orderById: orderById ?? this.orderById,
      errorMessage: errorMessage ?? this.errorMessage,
      oderMeStatus: oderMeStatus ?? this.oderMeStatus,
    );
  }

  @override
  List<Object?> get props => [
        orders,
        order,
        orderById,
        errorMessage,
        oderMeStatus,
      ];
}
