import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/bloc/auth/auth_bloc.dart';
import 'package:flutter_assigment10v1/bloc/order_me/order_me_bloc.dart';
import 'package:flutter_assigment10v1/components/product_image.dart';
import 'package:flutter_assigment10v1/components/share/custom_textfield.dart';
import 'package:flutter_assigment10v1/models/order_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateOrderScreen extends StatefulWidget {
  const UpdateOrderScreen({super.key});

  @override
  State<UpdateOrderScreen> createState() => _UpdateOrderScreenState();
}

final formKeyUpdateOrder = GlobalKey<FormState>();
String? image;

File? _imageFile;

class _UpdateOrderScreenState extends State<UpdateOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final Order order = arguments["order"] as Order;
    final beerNameController = TextEditingController(text: order.beerName);
    final priceController = TextEditingController(text: order.price.toString());
    final alcoholController = TextEditingController(text: order.alcohol);
    final stockController = TextEditingController(text: order.stock.toString());
    final descriptionController =
        TextEditingController(text: order.description);

    handleSubmit() {
      if (formKeyUpdateOrder.currentState!.validate()) {
        formKeyUpdateOrder.currentState!.save();
        final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
        final OrderMeBloc orderBloc = context.read<OrderMeBloc>();

        final value = Order(
          beerName: beerNameController.text,
          description: descriptionController.text,
          price: int.parse(priceController.text),
          stock: int.parse(stockController.text),
          alcohol: alcoholController.text,
          shopName: authBloc.state.me!.shopName,
          userId: authBloc.state.me!.sub,
        );
        orderBloc.add(OrderMeUpdateEvent(value, _imageFile, order.id!));
      }
    }

    // ฟังก์ชันสำหรับเลือกรูปภาพ
    void callBackSetImage(File? imageFile) {
      setState(() {
        _imageFile = imageFile;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขสินค้า'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.save),
              onPressed: handleSubmit,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: formKeyUpdateOrder,
                child: Column(
                  children: [
                    const SizedBox(height: 10.0),
                    customTextFieldProduct(
                      controller: beerNameController,
                      labelText: "ชื่อเบียร์",
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกชื่อสินค้า';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    customTextFieldProduct(
                      controller: priceController,
                      obscureText: false,
                      labelText: "ราคา",
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please enter some text'
                          : null,
                    ),
                    const SizedBox(height: 10.0),
                    customTextFieldProduct(
                      controller: alcoholController,
                      obscureText: false,
                      labelText: "แอลกอฮอล์",
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please enter some text'
                          : null,
                    ),
                    const SizedBox(height: 10.0),
                    customTextFieldProduct(
                      controller: stockController,
                      obscureText: false,
                      labelText: "จำนวนสินค้า",
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please enter some text'
                          : null,
                    ),
                    const SizedBox(height: 10.0),
                    customTextFieldProduct(
                      controller: descriptionController,
                      obscureText: false,
                      labelText: "รายละเอียด",
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please enter some text'
                          : null,
                    ),
                    ProductImage(
                      callBackSetImage,
                      image: image,
                    ),
                    // ElevatedButton(
                    //   onPressed: handleSubmit,
                    //   child: const Text("Print Me Data"),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
