import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:new_kasir_apps/core/constants/variable.dart';
import 'package:new_kasir_apps/data/data_sources/auth_local.dart';
import 'package:new_kasir_apps/data/model/respons/auth_response_model.dart';

class AuthRemote {
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(Uri.parse('${Variable.baseUrl}/api/login'), body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, AuthResponseModel>> logout() async {
    final authData = await AuthLocal().getAuth();
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/logout'),
      headers: {'Authorization': 'Bearer ${authData.token}'},
    );
    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }
}
