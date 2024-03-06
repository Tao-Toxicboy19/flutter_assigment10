import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/components/share/custom_textfield.dart';

class AddOrderForm extends StatelessWidget {
  AddOrderForm({super.key});

  final _formKeyAddOrder = GlobalKey<FormState>();

  final _orderNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyAddOrder,
      child: Column(
        children: [
          customTextField(
            controller: _orderNameController,
            obscureText: false,
            labelText: "Product name",
            validator: (value) => (value == null || value.isEmpty)
                ? 'Please enter some text'
                : null,
            underlineText: true,
          ),
          customTextField(
            controller: _priceController,
            obscureText: false,
            labelText: "Price",
            validator: (value) => (value == null || value.isEmpty)
                ? 'Please enter some text'
                : null,
            underlineText: true,
          ),
          customTextField(
            controller: _descriptionController,
            obscureText: false,
            labelText: "Description",
            validator: (value) => (value == null || value.isEmpty)
                ? 'Please enter some text'
                : null,
            underlineText: true,
          ),
        ],
      ),
    );
  }
}
