// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/app_routes.dart';
import 'package:flutter_assigment10v1/bloc/bloc/order_bloc.dart';
import 'package:flutter_assigment10v1/models/order_model.dart';
import 'package:flutter_assigment10v1/utils/constants.dart';
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
    ordersBloc.add(FetchOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text(items.beerName),
                              subtitle: Text(items.description),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      const Text("ร้าน"),
                                      const SizedBox(width: 10),
                                      Text(items.shopName),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    // TextButton(
                                    //   child: const Text('BUY TICKETS'),
                                    //   onPressed: () {/* ... */},
                                    // ),
                                    const SizedBox(width: 8),
                                    TextButton(
                                      child: const Text('เพิ่มลงตะกร้า'),
                                      onPressed: () {/* ... */},
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                ),
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
}