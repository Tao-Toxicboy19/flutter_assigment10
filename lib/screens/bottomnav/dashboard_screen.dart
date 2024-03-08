// // ignore_for_file: use_build_context_synchronously, unused_element

// import 'package:flutter/material.dart';
// import 'package:flutter_assigment10v1/screens/add_order_screen.dart';
// import 'package:flutter_assigment10v1/screens/order_screen.dart';
// import 'package:flutter_assigment10v1/screens/profile_screen.dart';
// import 'package:flutter_assigment10v1/theme/colors.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   String _title = "Products";
//   int _currentIndex = 1;

//   final List<Widget> _pages = [
//     const AddOrderScreen(),
//     const OrderScreen(),
//     const ProfileScreen(),
//   ];

//   void onTapped(int index) {
//     setState(
//       () {
//         _currentIndex = index;
//         switch (index) {
//           case 0:
//             _title = "Add product";
//             break;
//           case 1:
//             _title = "Products";
//             break;
//           case 2:
//             _title = "Profile";
//             break;
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           _title,
//           style: TextStyle(
//             color: _title != "Profile" ? Colors.white70 : primary,
//           ),
//         ),
//         backgroundColor: _title != "Profile" ? primary : Colors.white,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: Stack(
//               children: [
//                 IconButton(
//                   icon: const Icon(
//                     Icons.shopping_cart,
//                     color: Colors.white70,
//                   ),
//                   onPressed: () {},
//                 ),
//                 const Positioned(
//                   top: 0,
//                   right: 0,
//                   child: CircleAvatar(
//                     radius: 10,
//                     backgroundColor: Colors.red, // สีพื้นหลังของเลข
//                     child: Text(
//                       '5',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bar_chart_outlined),
//             label: 'Add product',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'Products',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: 'Profile',
//           ),
//         ],
//         onTap: (value) {
//           onTapped(value);
//         },
//         currentIndex: _currentIndex,
//         type: BottomNavigationBarType.shifting,
//         selectedItemColor: Colors.amber.shade900,
//         unselectedItemColor: Colors.amber.shade600,
//       ),
//     );
//   }
// }
