// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/app_routes.dart';
import 'package:flutter_assigment10v1/bloc/auth/auth_bloc.dart';
import 'package:flutter_assigment10v1/bloc/order_me/order_me_bloc.dart';
import 'package:flutter_assigment10v1/components/share/custom_buttom.dart';
import 'package:flutter_assigment10v1/models/order_model.dart';
import 'package:flutter_assigment10v1/theme/colors.dart';
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
                                    Text(
                                      "ราคา ${items.price}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
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
                                InkWell(
                                  onTap: () {
                                    showDeleteConfirmationDialog(
                                        context, items.id!);
                                  },
                                  child: Container(
                                    width: 40, // กำหนดความกว้าง
                                    height: 40, // กำหนดความสูง
                                    decoration: const BoxDecoration(
                                      color: primary, // สีพื้นหลังของปุ่ม
                                      shape: BoxShape
                                          .circle, // รูปร่างของปุ่ม (วงกลม)
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white, // สีไอคอน
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                SizedBox(
                                  child: Row(
                                    children: [
                                      customButtom(
                                        labelText: 'แก้ไข',
                                        onPressd: () {
                                          Navigator.pushNamed(
                                            context,
                                            AppRouter.updateOrder,
                                            arguments: {
                                              "order": items,
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
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
                return Center(
                  child: Image.asset(
                    "assets/images/notfound.png",
                    height: 200,
                  ),
                );
              }
            } else if (state.oderMeStatus == OrderMeStatus.failed) {
              // กรณีเกิดข้อผิดพลาดในการโหลดข้อมูล
              return Center(
                child: Image.asset(
                  "assets/images/notfound.png",
                  height: 200,
                ),
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

  void showDeleteConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการลบ'),
          content: const Text('คุณแน่ใจหรือว่าต้องการลบรายการนี้หรือไม่?'),
          actions: [
            // ปุ่มยกเลิก
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Dialog
              },
              child: const Text('ยกเลิก'),
            ),
            // ปุ่มยืนยัน
            TextButton(
              onPressed: () async {
                final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
                // final Dio dio = DioConfig.dioWithAuth;
                // final result = await dio.delete('order/$id');
                // logger.i(result);
                final OrderMeBloc orderBloc = context.read<OrderMeBloc>();
                orderBloc.add(OrderMeDeleteEvent(id, authBloc.state.me!.sub));
                Navigator.of(context).pop();
              },
              child: const Text('ยืนยัน'),
            ),
          ],
        );
      },
    );
  }
}
