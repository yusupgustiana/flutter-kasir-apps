import 'dart:convert';

import 'package:new_kasir_apps/data/model/respons/product_respons.dart';

class AddProductResponseModel {
  final bool success;
  final String message;
  final Product data;

  AddProductResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AddProductResponseModel.fromJson(String str) =>
      AddProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddProductResponseModel.fromMap(Map<String, dynamic> json) =>
      AddProductResponseModel(
        success: json["success"],
        message: json["message"],
        data: Product.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data.toMap(),
      };
}
