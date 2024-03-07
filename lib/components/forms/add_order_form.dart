import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/components/share/custom_textfield.dart';

class AddOrderForm extends StatelessWidget {
  AddOrderForm({super.key});

  final _formKeyAddOrder = GlobalKey<FormState>();

  final _beerNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _alcoholController = TextEditingController();
  final _stockController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyAddOrder,
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
        ],
      ),
    );
  }
}
