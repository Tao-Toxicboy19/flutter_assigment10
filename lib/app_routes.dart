// ignore_for_file: prefer_const_constructors

import 'package:flutter_assigment10v1/screens/add_order_screen.dart';
import 'package:flutter_assigment10v1/screens/cart_screen.dart';
import 'package:flutter_assigment10v1/screens/login_screen.dart';
import 'package:flutter_assigment10v1/screens/order_screen.dart';
import 'package:flutter_assigment10v1/screens/productmy_screen.dart';
import 'package:flutter_assigment10v1/screens/profile_screen.dart';
import 'package:flutter_assigment10v1/screens/register_screen.dart';
import 'package:flutter_assigment10v1/screens/update_order_screen.dart';

class AppRouter {
  static const String login = 'login';
  static const String register = 'register';
  static const String product = 'product';
  static const String profile = 'profile';
  static const String addOrder = 'addOrder';
  static const String productmMy = 'productmMy';
  static const String cart = 'cart';
  static const String updateOrder = 'updateOrder';

  static get routes => {
        login: (context) => LoginScreen(),
        register: (context) => RegisterScreen(),
        product: (context) => OrderScreen(),
        profile: (context) => ProfileScreen(),
        addOrder: (context) => AddOrderScreen(),
        productmMy: (context) => ProductMyScreen(),
        cart: (context) => CartScreen(),
        updateOrder: (context) => UpdateOrderScreen()
      };
}
