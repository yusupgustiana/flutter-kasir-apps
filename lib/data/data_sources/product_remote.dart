import 'package:dartz/dartz.dart';
import 'package:flutter_kasir_apps_frontend/core/constants/variable.dart';
import 'package:flutter_kasir_apps_frontend/data/data_sources/auth_local.dart';
import 'package:flutter_kasir_apps_frontend/data/model/respons/product_respons.dart';
import 'package:http/http.dart' as http;

class ProductRemote {
  Future<Either<String, ProductResponseModel>> getProducts() async {
    final authData = await AuthLocal().getAuth();
    final response = await http.get(
      Uri.parse('${Variable.baseUrl}/api/products'),
      headers: {'Authorization': 'Bearer ${authData!.token}'},
    );
if (response.statusCode == 200) {
  return Right(ProductResponseModel.fromJson(response.body));
}
else {
  return Left(response.body);
}
  }
}
