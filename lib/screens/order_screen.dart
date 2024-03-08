// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/app_routes.dart';
import 'package:flutter_assigment10v1/bloc/auth/auth_bloc.dart';
import 'package:flutter_assigment10v1/bloc/cart_count/cart_count_bloc.dart';
import 'package:flutter_assigment10v1/bloc/order/order_bloc.dart';
import 'package:flutter_assigment10v1/components/share/custom_buttom.dart';
import 'package:flutter_assigment10v1/models/order_model.dart';
import 'package:flutter_assigment10v1/theme/colors.dart';
import 'package:flutter_assigment10v1/utils/constants.dart';
import 'package:flutter_assigment10v1/utils/logger.dart';
import 'package:flutter_assigment10v1/utils/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    final OrderBloc ordersBloc = context.read<OrderBloc>();
    final AuthBloc authBloc = context.read<AuthBloc>();
    ordersBloc.add(FetchOrdersEvent());
    authBloc.add(MeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Products",
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
        backgroundColor: primary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        // เพิ่มโค้ดที่ต้องการทำเมื่อคลิกที่ปุ่ม "Shopping Cart" ที่นี่
                      },
                    ),
                    BlocBuilder<CartCountBloc, CartCountState>(
                      builder: (context, state) {
                        return state.cartCount != 0
                            ? Positioned(
                                top: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor:
                                      Colors.red, // สีพื้นหลังของเลข
                                  child: Text(
                                    state.cartCount.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.profile);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state.orderStatus == OrderStatus.success) {
              // นำข้อมูล orders มาแสดงที่นี่
              List<Order> orders = state.result ?? [];

              // ตรวจสอบว่ามีข้อมูล order หรือไม่
              if (orders.isNotEmpty) {
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    Order items = orders[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: CachedNetworkImage(
                                imageUrl: imageUrl + items.image!,
                                height: 100,
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
                                    Text(
                                      "แอลกอฮอล์ ${items.alcohol}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "จำนวนสินค้า ${items.stock}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ราคา ${items.price}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                customButtom(
                                    labelText: 'เพิ่มลงตะกร้า',
                                    onPressd: cartCount)
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                // กรณีไม่มีข้อมูล order
                return const Center(
                  child: Text('No orders available.'),
                );
              }
            } else if (state.orderStatus == OrderStatus.failed) {
              // กรณีเกิดข้อผิดพลาดในการโหลดข้อมูล
              return const Center(
                child: Text('Failed to load orders.'),
              );
            } else {
              // กรณีกำลังโหลดข้อมูล
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _handlerLogout(BuildContext context) async {
    await MySharedPreferences.removeSharedPreference(token);
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouter.login,
      (route) => false,
    );
  }

  void cartCount() {
    final CartCountBloc count = BlocProvider.of<CartCountBloc>(context);
    final CartCountBloc cartCount = context.read<CartCountBloc>();
    cartCount.add(CartCountsEvent());
    logger.f(count.state.cartCount);
  }
}
