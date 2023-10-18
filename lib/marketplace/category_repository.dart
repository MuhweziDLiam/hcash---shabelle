import 'package:h_cash/marketplace/category_response.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/services/apis.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  Future<CategoryResponse> getCategories({parent_id = 0}) async {
    Uri url = Uri.parse("$shabelleAPI/categories?parent_id=${parent_id}");
    final response = await http.get(url, headers: {
      "App-Language": app_language.$,
    });
    // print("$shabelleAPI/categories?parent_id=${parent_id}");
    // print(response.body.toString());
    return categoryResponseFromJson(response.body);
  }

  Future<CategoryResponse> getFeturedCategories() async {
    Uri url = Uri.parse("$shabelleAPI/categories/featured");
    final response = await http.get(url, headers: {
      "App-Language": app_language.$,
    });
    //print(response.body.toString());
    //print("--featured cat--");
    return categoryResponseFromJson(response.body);
  }

  Future<CategoryResponse> getTopCategories() async {
    Uri url = Uri.parse("$shabelleAPI/categories/top");
    final response = await http.get(url, headers: {
      "App-Language": app_language.$,
    });
    return categoryResponseFromJson(response.body);
  }

  Future<CategoryResponse> getFilterPageCategories() async {
    Uri url = Uri.parse("$shabelleAPI/filter/categories");
    final response = await http.get(url, headers: {
      "App-Language": app_language.$,
    });
    return categoryResponseFromJson(response.body);
  }
}
