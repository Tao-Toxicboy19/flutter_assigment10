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

  String? image;

  @override
  Widget build(BuildContext context) {
    // final bloc = BlocProvider.of<AuthBloc>(context);
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
            ElevatedButton(
              onPressed: () {
                final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
                logger.f(authBloc.state.me!.sub);
              },
              child: const Text("Print Me Data"),
            )
          ],
        ),
      ),
    );
  }
}


//  final value = {
//                   "beerName": _beerNameController.text,
//                   "description": _descriptionController.text,
//                   "price": _priceController.text,
//                   "stock": _stockController.text,
//                 };
//                 final CallAPI service = CallAPI();
//                 service.addProductAPI(value, imageFile: _imageFile);