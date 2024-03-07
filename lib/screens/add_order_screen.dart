import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/components/forms/add_order_form.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: AddOrderForm(),
        ),
      ),
    );
  }
}
