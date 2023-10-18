import 'package:h_cash/marketplace/cart_add_response.dart';
import 'package:h_cash/marketplace/cart_count_response.dart';
import 'package:h_cash/marketplace/cart_delete_response.dart';
import 'package:h_cash/marketplace/cart_process_response.dart';
import 'package:h_cash/marketplace/cart_response.dart';
import 'package:h_cash/marketplace/cart_summary_response.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/services/apis.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class CartRepository {
  Future<List<CartResponse>> getCartResponseList(
    @required int user_id,
  ) async {
    print(access_token.$);
    Uri url = Uri.parse("$shabelleAPI/carts");
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$,
      },
    );

    return cartResponseFromJson(response.body);
  }

  Future<CartCountResponse> getCartCount() async {
    Uri url = Uri.parse("$shabelleAPI/cart-count");
    print(access_token.$);
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$,
      },
    );
    print(response.body);

    return cartCountResponseFromJson(response.body);
  }

  Future<CartDeleteResponse> getCartDeleteResponse(
    @required int cart_id,
  ) async {
    Uri url = Uri.parse("$shabelleAPI/carts/$cart_id");
    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$
      },
    );

    return cartDeleteResponseFromJson(response.body);
  }

  Future<CartProcessResponse> getCartProcessResponse(
      @required String cart_ids, @required String cart_quantities) async {
    var post_body = jsonEncode(
        {"cart_ids": "${cart_ids}", "cart_quantities": "$cart_quantities"});

    Uri url = Uri.parse("$shabelleAPI/carts/process");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: post_body);

    return cartProcessResponseFromJson(response.body);
  }

  Future<CartAddResponse> getCartAddResponse(
      @required int id,
      @required String variant,
      @required int user_id,
      @required int quantity) async {
    var post_body = jsonEncode({
      "id": "${id}",
      "variant": "$variant",
      "user_id": "$user_id",
      "quantity": "$quantity",
      "cost_matrix": purchase_code
    });

    print(post_body.toString());

    Uri url = Uri.parse("$shabelleAPI/carts/add");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: post_body);

    print(response.body.toString());
    return cartAddResponseFromJson(response.body);
  }

  Future<CartSummaryResponse> getCartSummaryResponse() async {
    Uri url = Uri.parse("$shabelleAPI/cart-summary");
    print(" cart summary");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$
      },
    );
    print("access token ${access_token.$}");

    print("cart summary res ${response.body}");
    return cartSummaryResponseFromJson(response.body);
  }
}
