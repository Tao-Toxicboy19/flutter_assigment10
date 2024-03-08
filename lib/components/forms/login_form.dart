import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/app_routes.dart';
import 'package:flutter_assigment10v1/bloc/auth/auth_bloc.dart';
import 'package:flutter_assigment10v1/components/share/custom_buttom.dart';
import 'package:flutter_assigment10v1/components/share/custom_textfield.dart';
import 'package:flutter_assigment10v1/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final _formKeyLogin = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyLogin,
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
          const SizedBox(height: 10.0),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state.authStatus == AuthStatus.failed) {
                return Container(
                  width: double.infinity,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red.shade900,
                      width: 1.0,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Login Failed',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red.shade900,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            height: 45.0,
            child: customButtom(
              labelText: "Login",
              onPressd: () => handleLogin(context),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            height: 45.0,
            child: customButtom(
              labelText: "Register",
              onPressd: () {
                Navigator.pushNamed(context, AppRouter.register);
              },
            ),
          ),
          const SizedBox(height: 20),
          Image.asset("assets/images/login.png")
        ],
      ),
    );
  }

  void handleLogin(BuildContext context) {
    if (_formKeyLogin.currentState!.validate()) {
      _formKeyLogin.currentState!.save();
      final authBloc = context.read<AuthBloc>();
      final user = User(
        username: _usernameController.text,
        password: _passwordController.text,
      );
      authBloc.add(LoginEvent(user));
    }
  }
}
