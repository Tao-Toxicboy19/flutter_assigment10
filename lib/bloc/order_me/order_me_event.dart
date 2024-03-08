part of 'order_me_bloc.dart';

sealed class OrderMeEvent extends Equatable {
  const OrderMeEvent();

  @override
  List<Object> get props => [];
}

class AddOrderMeEvent extends OrderMeEvent {
  final Order payload;
  final File? file; // Use the alias here

  const AddOrderMeEvent(this.payload, this.file);
}

class FetchOrderByUserIdEvent extends OrderMeEvent {
  final String userId;
  const FetchOrderByUserIdEvent(this.userId);
}
