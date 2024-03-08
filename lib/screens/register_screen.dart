import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/components/forms/register_form.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(
            FocusNode(),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/bg.svg',
              fit: BoxFit.cover,
              height: 200,
              // height: 100.0,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ), // กำหนดระยะทางด้านล่าง
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  child: ClipRRect(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 35.0,
                        right: 35.0,
                        top: 10,
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 28,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          RegisterForm(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
