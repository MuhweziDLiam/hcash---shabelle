import 'package:h_cash/authorize_otp_response.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/responses/login_response.dart';
import 'package:h_cash/services/apis.dart';
import 'package:h_cash/user_by_token.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class AuthRepository {
  Future<LoginResponse> getLoginResponse(
      @required String email, @required String password) async {
    var postBody = jsonEncode({
      "phone": "${email}",
      "pin": "$password",
    });
    print(postBody);

    Uri url = Uri.parse("$shabelleAPI/auth/login");
    final response = await http.post(url,
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
          "App-Language": app_language.$,
        },
        body: postBody);
    print(response.body);

    return loginResponseFromJson(response.body);
  }

  Future<UserByTokenResponse> getUserByTokenResponse() async {
    var postBody = jsonEncode({"access_token": "${access_token.$}"});
    Uri url = Uri.parse("$shabelleAPI/get-user-by-access_token");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$,
        },
        body: postBody);
    print(response.body);

    return userByTokenResponseFromJson(response.body);
  }

  Future<AuthorizeOtpResponse> authorizeOTPResponse(
    String verificationCode,
    String phone,
  ) async {
    var postBody =
        jsonEncode({"message": verificationCode, "phoneNumber": phone});

    Uri url = Uri.parse("$shabelleAPI/sendSMS");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              'Basic ' + base64.encode(utf8.encode('admin:secret123')),
        },
        body: postBody);
    return authorizeOtpResponseFromJson(response.body);
  }
}
