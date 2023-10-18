// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse(this.status, this.message, this.name, this.phone, this.balance,
      this.access_token, this.avatar, this.user_id);

  final String status, message, name, phone, balance, access_token, avatar;
  final int user_id;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        json["status"],
        json["message"],
        json["name"] ?? '',
        json["phone"] ?? '',
        json["balance"] ?? '',
        json["access_token"] ?? '',
        json["avatar"] ?? '',
        json["user_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "name": name,
        "phone": phone,
        "balance": balance,
        "access_token": access_token,
        "avatar": avatar,
        "user_id": user_id,
      };
}
