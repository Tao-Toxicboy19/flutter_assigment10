part of 'order_bloc.dart'; // Make sure to include the correct file name

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class FetchOrdersEvent extends OrderEvent {}