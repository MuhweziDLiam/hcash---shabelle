// To parse this JSON data, do
//
//     final PaymentResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

PaymentResponse paymentResponseFromJson(String str) =>
    PaymentResponse.fromJson(json.decode(str));

String paymentResponseToJson(PaymentResponse data) =>
    json.encode(data.toJson());

class PaymentResponse {
  PaymentResponse(this.status, this.message, this.transactionId,
      this.appTransactionId, this.finalStatus);

  final String status, message, transactionId, appTransactionId, finalStatus;

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      PaymentResponse(
        json["status"],
        json["message"] ?? '',
        json["transactionId"] ?? '',
        json["appTransactionId"] ?? '',
        json["finalStatus"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "transactionId": transactionId,
        "appTransactionId": appTransactionId,
        "finalStatus": finalStatus,
      };
}
