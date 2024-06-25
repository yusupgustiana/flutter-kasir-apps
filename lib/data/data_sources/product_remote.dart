import 'package:dartz/dartz.dart';

import 'package:http/http.dart' as http;
import 'package:new_kasir_apps/core/constants/variable.dart';
import 'package:new_kasir_apps/data/data_sources/auth_local.dart';
import 'package:new_kasir_apps/data/model/request/product_request_model.dart';
import 'package:new_kasir_apps/data/model/respons/add_product_response_model.dart';
import 'package:new_kasir_apps/data/model/respons/product_respons.dart';

class ProductRemote {
//get Products
  Future<Either<String, ProductResponseModel>> getProducts() async {
    final authData = await AuthLocal().getAuth();
    final response = await http.get(
      Uri.parse('${Variable.baseUrl}/api/products'),
      headers: {'Authorization': 'Bearer ${authData.token}'},
    );
    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  // Future<Either<String, AddProductResponseModel>> addProduct(
  //     ProductRequestModel productRequestModel) async {
  //   final authData = await AuthLocal().getAuth();
  //   final Map<String, String> headers = {
  //     'Authorization': 'Bearer ${authData?.token}',
  //   };
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('${Variable.baseUrl}/api/products'));
  //   request.fields.addAll(productRequestModel.toMap());
  //   request.files.add(await http.MultipartFile.fromPath(
  //       'image', productRequestModel.image.path));
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   final String body = await response.stream.bytesToString();

  //   if (response.statusCode == 201) {
  //     return right(AddProductResponseModel.fromJson(body));
  //   } else {
  //     return left(body);
  //   }
  // }

  Future<Either<String, AddProductResponseModel>> addProduct(
      ProductRequestModel productRequestModel) async {
    final authData = await AuthLocal().getAuth();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData.token}',
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Variable.baseUrl}/api/products'));
    request.fields.addAll(productRequestModel.toMap());
    request.files.add(await http.MultipartFile.fromPath(
        'image', productRequestModel.image.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final String body = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      return right(AddProductResponseModel.fromJson(body));
    } else {
      return left(body);
    }
  }
}
