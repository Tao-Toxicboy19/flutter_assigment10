// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  String id;
  String orderName;
  String description;
  int price;
  String username;
  String userId;

  Order({
    required this.id,
    required this.orderName,
    required this.description,
    required this.price,
    required this.username,
    required this.userId,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["ID"],
        orderName: json["OrderName"],
        description: json["Description"],
        price: json["Price"],
        username: json["Username"],
        userId: json["UserId"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "OrderName": orderName,
        "Description": description,
        "Price": price,
        "Username": username,
        "UserId": userId,
      };
}
