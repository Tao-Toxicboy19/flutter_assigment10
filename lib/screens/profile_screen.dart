// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/app_routes.dart';
import 'package:flutter_assigment10v1/utils/constants.dart';
import 'package:flutter_assigment10v1/utils/shared_preferences.dart';

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
            const Text(
              "ชื่อร้าน นายก",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "อีเมล",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "อีเมล",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
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
            ElevatedButton(
              onPressed: handlerLogout,
              child: const Text("logout"),
            ),
          ],
        ),
      ),
    );
  }
}
