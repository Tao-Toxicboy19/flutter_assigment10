import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/bloc/auth/auth_bloc.dart';
import 'package:flutter_assigment10v1/components/share/custom_buttom.dart';
import 'package:flutter_assigment10v1/components/share/custom_textfield.dart';
import 'package:flutter_assigment10v1/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({super.key});

  final _formKeyRegister = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _shopNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyRegister,
      child: Column(
        children: [
          customTextField(
            controller: _shopNameController,
            obscureText: false,
            labelText: "Shop name",
            validator: (value) => (value == null || value.isEmpty)
                ? 'Please enter some text'
                : null,
            underlineText: true,
          ),
          const SizedBox(height: 16.0),
          customTextField(
            controller: _usernameController,
            obscureText: false,
            labelText: "Username",
            validator: (value) => (value == null || value.isEmpty)
                ? 'Please enter some text'
                : null,
            underlineText: true,
          ),
          const SizedBox(height: 10.0),
          customTextField(
            controller: _emailController,
            obscureText: false,
            labelText: "Email",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter email";
              } else if (!value.contains("@")) {
                return "Please enter your email address correctly.";
              }
              return null;
            },
            underlineText: true,
          ),
          const SizedBox(height: 16.0),
          customTextField(
            controller: _passwordController,
            obscureText: true,
            labelText: "Password",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter password";
              } else if (value.length < 6) {
                return "Please enter a password of at least 6 characters.";
              }
              return null;
            },
            underlineText: true,
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            height: 45.0,
            child: customButtom(
              labelText: "Create account",
              onPressd: () => handleLogin(context),
            ),
          ),
          const SizedBox(height: 30),
          Image.asset(
            "assets/images/register.png",
            height: 200,
          )
        ],
      ),
    );
  }

  void handleLogin(BuildContext context) {
    if (_formKeyRegister.currentState!.validate()) {
      _formKeyRegister.currentState!.save();
      final authBloc = context.read<AuthBloc>();
      final user = User(
        username: _usernameController.text,
        password: _passwordController.text,
        email: _emailController.text,
        shopName: _shopNameController.text,
      );
      authBloc.add(RegisterEvent(user));
    }
  }
}
