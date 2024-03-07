import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/bloc/auth/auth_bloc.dart';
import 'package:flutter_assigment10v1/components/product_image.dart';
import 'package:flutter_assigment10v1/components/share/custom_textfield.dart';
import 'package:flutter_assigment10v1/services/api_service.dart';
import 'package:flutter_assigment10v1/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOrderForm extends StatefulWidget {
  const AddOrderForm({super.key});

  @override
  State<AddOrderForm> createState() => _AddOrderFormState();
}

class _AddOrderFormState extends State<AddOrderForm> {
  final _formKeyAddOrder = GlobalKey<FormState>();

  final _beerNameController = TextEditingController();

  final _priceController = TextEditingController();

  final _alcoholController = TextEditingController();

  final _stockController = TextEditingController();

  final _descriptionController = TextEditingController();

  String? image;

  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyAddOrder,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            customTextFieldProduct(
              controller: _beerNameController,
              labelText: "ชื่อเบียร์",
              obscureText: false,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'Please enter some text'
                  : null,
            ),
            const SizedBox(height: 10.0),
            customTextFieldProduct(
              controller: _priceController,
              obscureText: false,
              labelText: "ราคา",
              validator: (value) => (value == null || value.isEmpty)
                  ? 'Please enter some text'
                  : null,
            ),
            const SizedBox(height: 10.0),
            customTextFieldProduct(
              controller: _alcoholController,
              obscureText: false,
              labelText: "แอลกอฮอล์",
              validator: (value) => (value == null || value.isEmpty)
                  ? 'Please enter some text'
                  : null,
            ),
            const SizedBox(height: 10.0),
            customTextFieldProduct(
              controller: _stockController,
              obscureText: false,
              labelText: "จำนวนสินค้า",
              validator: (value) => (value == null || value.isEmpty)
                  ? 'Please enter some text'
                  : null,
            ),
            const SizedBox(height: 10.0),
            customTextFieldProduct(
              controller: _descriptionController,
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
            ElevatedButton(
              onPressed: () {
                final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
                final value = {
                  "user_id": authBloc.state.me!.sub,
                  "beerName": _beerNameController.text,
                  "description": _descriptionController.text,
                  "price": _priceController.text,
                  "stock": _stockController.text,
                  "alcohol": _alcoholController.text,
                  "shopName": authBloc.state.me!.shopName,
                };
                final CallAPI service = CallAPI();
                service.addProductAPI(value, imageFile: _imageFile);
              },
              child: const Text("Print Me Data"),
            )
          ],
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
}
