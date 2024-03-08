// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/app_routes.dart';
import 'package:flutter_assigment10v1/bloc/auth/auth_bloc.dart';
import 'package:flutter_assigment10v1/utils/constants.dart';
import 'package:flutter_assigment10v1/utils/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> handlerLogout() async {
      await MySharedPreferences.removeSharedPreference(token);
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouter.login,
        (route) => false,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return buildText("ชื่อร้าน", state.me!.shopName);
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return buildText("อีเมล", state.me!.email);
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return buildText("ชื่อผู้ใช้", state.me!.username);
              },
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.productmMy);
              },
              icon: const Icon(
                Icons.shopping_cart,
                size: 24.0,
              ),
              label: const Text("สินค้าของฉัน"),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.addOrder);
              },
              icon: const Icon(
                Icons.add,
                size: 24.0,
              ),
              label: const Text("เพิ่มสินค้า"),
            ),
            ElevatedButton(
              onPressed: handlerLogout,
              child: const Text("logout"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildText(String title, String value) {
    return Text(
      "$title $value",
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      ),
    );
  }
}
