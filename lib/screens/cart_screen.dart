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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<CartCountBloc, CartCountState>(
          builder: (context, state) {
            final List<Order> cartOrders = state.cartOrder ?? [];
            final Map<String, int>? productCount = state.productCount;

            return ListView.builder(
              itemCount: cartOrders.length,
              itemBuilder: (context, index) {
                Order items = cartOrders[index];
                // เช็คว่า id ของ items มีอยู่ใน productCount หรือไม่
                int count = productCount?[items.id ?? ''] ?? 0;
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          child: CachedNetworkImage(
                            imageUrl: imageUrl + items.image!,
                            height: 150,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, protected) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    items.beerName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ),
                                Text(
                                  items.description,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text((items.price * count).toString()),
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            // color: Colors.white,
                                            onPressed: () =>
                                                removeCart(items.id!),
                                          ),
                                          Text(count.toString()),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            // color: Colors.white,
                                            onPressed: () => addCart(items.id!),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void removeCart(String id) {
    final CartCountBloc cartCount = context.read<CartCountBloc>();
    cartCount.add(CartRemoveEvent(id));
  }

  void addCart(String id) {
    final CartCountBloc cartCount = context.read<CartCountBloc>();
    cartCount.add(CartAddEvent(id));
  }
}
