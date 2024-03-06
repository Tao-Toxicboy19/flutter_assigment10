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
  String beerName;
  String description;
  String alcohol;
  int price;
  int stock;
  String image;
  String shopName;
  String userId;

  Order({
    required this.id,
    required this.beerName,
    required this.description,
    required this.alcohol,
    required this.price,
    required this.stock,
    required this.image,
    required this.shopName,
    required this.userId,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["ID"],
        beerName: json["BeerName"],
        description: json["Description"],
        alcohol: json["Alcohol"],
        price: json["Price"],
        stock: json["Stock"],
        image: json["Image"],
        shopName: json["ShopName"],
        userId: json["UserId"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "BeerName": beerName,
        "Description": description,
        "Alcohol": alcohol,
        "Price": price,
        "Stock": stock,
        "Image": image,
        "ShopName": shopName,
        "UserId": userId,
      };
}
