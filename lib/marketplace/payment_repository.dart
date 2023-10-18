import 'package:h_cash/marketplace/order_create_response.dart';
import 'package:h_cash/marketplace/payment_type_response.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/marketplace/transaction_response.dart';
import 'package:h_cash/services/apis.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class PaymentRepository {
  Future<List<PaymentTypeResponse>> getPaymentResponseList(
      {mode = "", list = "both"}) async {
    Uri url = Uri.parse("$shabelleAPI/payment-types?mode=${mode}&list=${list}");

    print("getPaymentResponseList url " + url.toString());

    final response = await http.get(url, headers: {
      "App-Language": app_language.$,
    });

    //print("getPaymentResponseList" + response.body);

    return paymentTypeResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponse(
      @required payment_method) async {
    var post_body = jsonEncode({"payment_type": "${payment_method}"});

    Uri url = Uri.parse("$shabelleAPI/order/store");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$,
        },
        body: post_body);
    return orderCreateResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponseFromWallet(
      @required payment_method, @required double amount) async {
    Uri url = Uri.parse("$shabelleAPI/payments/pay/wallet");

    var post_body = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "${payment_method}",
      "amount": "${amount}"
    });

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: post_body);

    //print(response.body.toString());
    return orderCreateResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponseFromCod(
      @required payment_method) async {
    var post_body = jsonEncode(
        {"user_id": "${user_id.$}", "payment_type": "${payment_method}"});

    Uri url = Uri.parse("$shabelleAPI/payments/pay/cod");

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}"
        },
        body: post_body);

    //print(response.body.toString());
    return orderCreateResponseFromJson(response.body);
  }

  Future<TransactionResponse> transactionResponse(
      fromAccount,
      toAccount,
      transactionAmount,
      serviceName,
      walletId,
      phoneNumber,
      senderName,
      receiverName,
      transactionId,
      {repaymentPeriod,
      fundPurpose,
      nextOfKinName,
      nextOfKinContact}) async {
    transactionAmount = transactionAmount.toString();
    var postBody = jsonEncode({
      "fromAccount": fromAccount,
      "toAccount": toAccount,
      "transactionAmount": transactionAmount,
      "serviceName": serviceName,
      "walletId": walletId,
      "phoneNumber": phoneNumber,
      "fromAmount": transactionAmount,
      "toAmount": transactionAmount,
      "senderName": senderName,
      "receiverName": user_name.$,
      "transactionId": transactionId,
      "narration": "merchant payment",
      "appVersion": '1.0.0+1',
      "checkoutMode": "HUSTLAZWALLET",
      "debitType": "HUSTLAZWALLET",
      "toCurrency": 'UGX',
      "fromCurrency": 'UGX',
      "reversalReference": "",
      "osType": "ANDROID",
      "repaymentPeriod": repaymentPeriod ?? '',
      "fundPurpose": fundPurpose ?? '',
      "nextOfKinName": nextOfKinName ?? '',
      "nextOfKinContact": nextOfKinContact ?? ''
    });

    Uri url = Uri.parse("$shabelleAPI/processWalletPayment");
    print(postBody);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              'Basic ' + base64.encode(utf8.encode('admin:secret123')),
        },
        body: postBody);

    return transactionResponseFromJson(response.body);
  }

  Future<TransactionResponse> transactionStatusResponse(transactionId) async {
    Uri url = Uri.parse("$shabelleAPI/getTransactionStatus/" + transactionId);

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            'Basic ' + base64.encode(utf8.encode('admin:secret123')),
      },
    );

    return transactionResponseFromJson(response.body);
  }

  Future<TransactionResponse> transactionOTPResponse(
    data,
  ) async {
    Uri url = Uri.parse("$shabelleAPI/authorizeWalletPayment");

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              'Basic ' + base64.encode(utf8.encode('admin:secret123')),
        },
        body: data);

    return transactionResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponseFromManualPayment(
      @required payment_method) async {
    var post_body = jsonEncode(
        {"user_id": "${user_id.$}", "payment_type": "${payment_method}"});

    Uri url = Uri.parse("$shabelleAPI/payments/pay/manual");

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: post_body);

    //print(response.body.toString());
    return orderCreateResponseFromJson(response.body);
  }
}
