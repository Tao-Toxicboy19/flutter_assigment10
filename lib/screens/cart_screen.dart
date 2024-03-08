import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/bloc/cart_count/cart_count_bloc.dart';
import 'package:flutter_assigment10v1/models/order_model.dart';
import 'package:flutter_assigment10v1/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    final CartCountBloc cartCountBloc = context.read<CartCountBloc>();
    cartCountBloc.add(FetchCountsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ตะกร้า'),
      ),
      body: BlocBuilder<CartCountBloc, CartCountState>(
        builder: (context, state) {
          final List<Order>? cartOrders = state.cartOrder;
          return ListView.builder(
            itemCount: cartOrders!.length,
            itemBuilder: (context, index) {
              Order items = cartOrders[index];
              return Column(
                children: [
                  Text(items.beerName),
                  // Text(items),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
