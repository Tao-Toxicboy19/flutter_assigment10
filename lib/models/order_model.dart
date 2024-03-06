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
  int price;

  Order({
    required this.id,
    required this.orderName,
    required this.price,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["ID"],
        orderName: json["OrderName"],
        price: json["Price"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "OrderName": orderName,
        "Price": price,
      };
}
