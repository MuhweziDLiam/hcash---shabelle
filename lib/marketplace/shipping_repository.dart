import 'package:h_cash/marketplace/delivery_info_response.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/services/apis.dart';
import 'package:http/http.dart' as http;

class ShippingRepository {
  Future<List<DeliveryInfoResponse>> getDeliveryInfo() async {
    Uri url = Uri.parse("$shabelleAPI/delivery-info");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$,
      },
    );
    print("response.body.toString()${response.body.toString()}");

    return deliveryInfoResponseFromJson(response.body);
  }
}
