import 'dart:convert';

import 'package:h_cash/responses/login_response.dart';
import 'package:h_cash/responses/register_response.dart';
import 'package:h_cash/responses/validate_account_response.dart';
import 'package:h_cash/services/apis.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<LoginResponse> getLoginResponse(String phone, String pin) async {
    var postBody = jsonEncode({
      "phone": phone,
      "pin": pin,
    });

    Uri url = Uri.parse("$shabelleAPI/login");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);
    return loginResponseFromJson(response.body);
  }

  Future<RegisterResponse> getRegisterResponse(
      String phone, String name, String pin) async {
    var postBody = jsonEncode({
      "name": name,
      "phone": phone,
      "pin": pin,
    });

    Uri url = Uri.parse("$shabelleAPI/auth/register");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);
    print(response.body);

    return registerResponseFromJson(response.body);
  }

  Future<RegisterResponse> smsResponse(
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
              'Basic ${base64.encode(utf8.encode('admin:secret123'))}',
        },
        body: postBody);
    print(response.body);
    return registerResponseFromJson(response.body);
  }

  Future<ValidateAccountResponse> validateAccountResponse(
    String walletId,
  ) async {
    var postBody = jsonEncode({
      "walletId": walletId,
    });

    Uri url = Uri.parse("$shabelleAPI/validateAccount");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);

    print(response.body);

    return validateAccountResponseFromJson(response.body);
  }

  Future<ValidateAccountResponse> validateMerchantAccountResponse(
    String walletId,
  ) async {
    var postBody = jsonEncode({
      "walletId": walletId,
    });

    Uri url = Uri.parse("$shabelleAPI/validateMerchantAccount");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);

    print(response.body);

    return validateAccountResponseFromJson(response.body);
  }

  Future<RegisterResponse> changePinResponse(
    String username,
    String oldPin,
    String pin,
  ) async {
    var postBody = jsonEncode({
      "username": username,
      "old_pin": oldPin,
      "pin": pin,
    });

    Uri url = Uri.parse("$shabelleAPI/changePin");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);
    print(response.body);
    return registerResponseFromJson(response.body);
  }

  Future<ValidateAccountResponse> queryWalletBalanceResponse(
    String username,
  ) async {
    var postBody = jsonEncode({
      "username": username,
    });

    print(postBody);

    Uri url = Uri.parse("$shabelleAPI/queryWalletBalance");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);

    return validateAccountResponseFromJson(response.body);
  }
}
