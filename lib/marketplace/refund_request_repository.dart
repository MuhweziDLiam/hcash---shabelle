import 'package:h_cash/marketplace/refund_request_response.dart';
import 'package:h_cash/marketplace/refund_request_send_response.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/services/apis.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class RefundRequestRepository {
  Future<RefundRequestResponse> getRefundRequestListResponse({page = 1}) async {
    Uri url = Uri.parse("$shabelleAPI/refund-request/get-list");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$,
      },
    );
    //print(response.body.toString());
    return refundRequestResponseFromJson(response.body);
  }

  Future<RefundRequestSendResponse> getRefundRequestSendResponse(
      {required int id, required String reason}) async {
    var post_body = jsonEncode({
      "id": "${id}",
      "reason": "${reason}",
    });

    Uri url = Uri.parse("$shabelleAPI/refund-request/send");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$,
        },
        body: post_body);

    return refundRequestSendResponseFromJson(response.body);
  }
}