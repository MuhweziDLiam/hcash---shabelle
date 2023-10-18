import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/marketplace/slider_response.dart';
import 'package:h_cash/services/apis.dart';
import 'package:http/http.dart' as http;

class SlidersRepository {
  Future<SliderResponse> getSliders() async {
    Uri url = Uri.parse("$shabelleAPI/sliders");
    final response = await http.get(
      url,
      headers: {
        "App-Language": app_language.$,
      },
    );
    return sliderResponseFromJson(response.body);
  }

  Future<SliderResponse> getBannerOneImages() async {
    Uri url = Uri.parse("$shabelleAPI/banners-one");
    final response = await http.get(
      url,
      headers: {
        "App-Language": app_language.$,
      },
    );
    /*print(response.body.toString());
    print("sliders");*/
    return sliderResponseFromJson(response.body);
  }

  Future<SliderResponse> getBannerTwoImages() async {
    Uri url = Uri.parse("$shabelleAPI/banners-two");
    final response = await http.get(
      url,
      headers: {
        "App-Language": app_language.$,
      },
    );
    /*print(response.body.toString());
    print("sliders");*/
    return sliderResponseFromJson(response.body);
  }

  Future<SliderResponse> getBannerThreeImages() async {
    Uri url = Uri.parse("$shabelleAPI/banners-three");
    final response = await http.get(
      url,
      headers: {
        "App-Language": app_language.$,
      },
    );
    /*print(response.body.toString());
    print("sliders");*/
    return sliderResponseFromJson(response.body);
  }
}
