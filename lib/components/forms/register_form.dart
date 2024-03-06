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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyRegister,
      child: Column(
        children: [
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
            controller: _passwordController,
            obscureText: true,
            labelText: "Password",
            validator: (value) => (value == null || value.isEmpty)
                ? 'Please enter some text'
                : null,
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
          // const SizedBox(height: 10.0),
          // SizedBox(
          //   width: double.infinity,
          //   height: 45.0,
          //   child: customButtom(
          //     labelText: "Register",
          //     onPressd: () {},
          //   ),
          // )
        ],
      ),
    );
  }

  void handleLogin(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final user = User(
      username: _usernameController.text,
      password: _passwordController.text,
    );
    authBloc.add(RegisterEvent(user));
  }
}
