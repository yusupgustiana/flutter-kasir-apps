import 'package:dartz/dartz.dart';
import 'package:flutter_kasir_apps_frontend/core/constants/variable.dart';
import 'package:flutter_kasir_apps_frontend/data/model/respons/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemote {
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(Uri.parse('${Variable.baseUrl}/api/login'), 
    body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromRawJson(response.body));
    } else {
      return Left(response.body);
    }
  
  }
}
