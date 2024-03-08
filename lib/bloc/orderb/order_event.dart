part of 'order_bloc.bak';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class FetchOrdersEvent extends OrderEvent {}

class AddOrderEvent extends OrderEvent {
  final Order payload;
  final io.File? file; // Use the alias here

  const AddOrderEvent(this.payload, this.file);
}

class FetchOrderByUserIdEvent extends OrderEvent {
  final String userId;
  const FetchOrderByUserIdEvent(this.userId);
}
