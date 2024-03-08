import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/bloc/auth/auth_bloc.dart';
import 'package:flutter_assigment10v1/bloc/order/order_bloc.dart';
import 'package:flutter_assigment10v1/bloc/order_me/order_me_bloc.dart';
import 'package:flutter_assigment10v1/components/share/custom_buttom.dart';
import 'package:flutter_assigment10v1/models/order_model.dart';
import 'package:flutter_assigment10v1/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductMyScreen extends StatefulWidget {
  const ProductMyScreen({super.key});

  @override
  State<ProductMyScreen> createState() => _ProductMyScreenState();
}

class _ProductMyScreenState extends State<ProductMyScreen> {
  @override
  void initState() {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    final OrderMeBloc ordersMeBloc = context.read<OrderMeBloc>();
    ordersMeBloc.add(FetchOrderByUserIdEvent(authBloc.state.me!.sub));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สินค้าของฉัน'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<OrderMeBloc, OrderMeState>(
          builder: (context, state) {
            if (state.oderMeStatus == OrderMeStatus.success) {
              // นำข้อมูล orders มาแสดงที่นี่
              List<Order> orders = state.orderById ?? [];

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
                                    labelText: 'แก้ไข', onPressd: () {})
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
                return Center(
                  child: Image.asset(
                    "assets/images/notfound.png",
                    height: 200,
                  ),
                );
              }
            } else if (state.oderMeStatus == OrderMeStatus.failed) {
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
      // body: Center(
      //   child: Image.asset(
      //     "assets/images/notfound.png",
      //     height: 200,
      //   ),
      // ),
    );
  }
}
