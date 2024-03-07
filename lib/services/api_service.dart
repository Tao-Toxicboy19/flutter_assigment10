import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_assigment10v1/models/order_model.dart';
import 'package:flutter_assigment10v1/services/dio_config.dart';
import 'package:flutter_assigment10v1/utils/logger.dart';
import 'package:http_parser/http_parser.dart';

class CallAPI {
  // สร้าง Dio Instance
  final Dio _dio = DioConfig.dio;
  final Dio _dioWithAuth = DioConfig.dioWithAuth;

  // ---------------------------------------------------------------------------

  // Create Product API Method -------------------------------------------------
  Future<String> addProductAPI(value, {File? imageFile}) async {
    FormData data = FormData.fromMap({
      "beerName": value["beerName"],
      "description": value["description"],
      "Alcohol": value["alcohol"],
      "price": value["price"],
      "stock": value["stock"],
      "ShopName": value["shopName"],
      "UserId": value["user_id"],
      if (imageFile != null)
        "files": await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType("image", "jpg"),
        ),
    });
    // logger.d(data);
    final response = await _dioWithAuth.post('order', data: data);
    logger.d(response.data);
    // if (response.statusCode == 200) {
    //   logger.d(response.data);
    //   return jsonEncode(response.data);
    // }
    return "OK";
    // throw Exception('Failed to create product');
  }
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------

  // Update Product API Method -------------------------------------------------
  // ---------------------------------------------------------------------------
}
