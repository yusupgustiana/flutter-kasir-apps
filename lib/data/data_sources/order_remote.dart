import 'package:http/http.dart' as http;
import 'package:new_kasir_apps/core/constants/variable.dart';
import 'package:new_kasir_apps/data/data_sources/auth_local.dart';
import 'package:new_kasir_apps/data/model/request/order_request-model.dart';

class OrderRemote {
  Future<bool> sendOrder(OrderRequestModel requestModel) async {
    final Url = Uri.parse('${Variable.baseUrl}/api/orders');
    final authData = await AuthLocal().getAuth();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    print(requestModel.toJson());
    final response =
        await http.post(Url, headers: headers, body: requestModel.toJson());

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
