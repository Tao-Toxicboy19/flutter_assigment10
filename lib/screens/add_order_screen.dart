import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/bloc/auth/auth_bloc.dart';
import 'package:flutter_assigment10v1/bloc/order_me/order_me_bloc.dart';
import 'package:flutter_assigment10v1/components/product_image.dart';
import 'package:flutter_assigment10v1/components/share/custom_textfield.dart';
import 'package:flutter_assigment10v1/models/order_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

final formKeyAddOrder = GlobalKey<FormState>();

final beerNameController = TextEditingController();

final priceController = TextEditingController();

final alcoholController = TextEditingController();

final stockController = TextEditingController();

final descriptionController = TextEditingController();

String? image;

File? _imageFile;

class _AddOrderScreenState extends State<AddOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มสินค้า'),
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
                key: formKeyAddOrder,
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
                      _callBackSetImage,
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

  // ฟังก์ชันสำหรับเลือกรูปภาพ
  void _callBackSetImage(File? imageFile) {
    setState(() {
      _imageFile = imageFile;
    });
  }

  handleSubmit() {
    if (formKeyAddOrder.currentState!.validate()) {
      formKeyAddOrder.currentState!.save();
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
      orderBloc.add(AddOrderMeEvent(value, _imageFile));
    }
  }
}
