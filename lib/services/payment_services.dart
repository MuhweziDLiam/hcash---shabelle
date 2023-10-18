import 'dart:convert';

import 'package:h_cash/responses/payment_response.dart';
import 'package:h_cash/responses/transaction_response.dart';
import 'package:h_cash/responses/validate_account_response.dart';
import 'package:h_cash/services/apis.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  Future<PaymentResponse> paymentResponse(
    String toAccount,
    String fromAccount,
    String transactionAmount,
    String narration,
    String serviceName,
    String senderName,
    String receiverName,
    String accountParticulars,
    String bankName,
    String transactionCharge,
  ) async {
    var postBody = jsonEncode({
      "toAccount": toAccount,
      "fromAccount": fromAccount,
      "transactionAmount": transactionAmount,
      "narration": narration,
      "serviceName": serviceName,
      "senderName": senderName,
      "receiverName": receiverName,
      "accountParticulars": accountParticulars,
      "bankName": bankName,
      "transactionCharge": transactionCharge,
    });
    Uri url;
    if (serviceName == 'BANK_TRANSFERS' ||
        serviceName == 'AIRTIME' ||
        serviceName == 'AIRTICKET' ||
        serviceName == 'TAXI' ||
        serviceName == 'WATER' ||
        serviceName == 'ELECTRICITY' ||
        serviceName == 'PAYTV' ||
        serviceName == 'WALLET_SCAN_TO_PAY' ||
        serviceName == 'SCHOOLFEES') {
      url = Uri.parse("$shabelleAPI/processUtilityPayment");
    } else {
      url = Uri.parse("$shabelleAPI/make-payment");
    }
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);
    print(response.body);

    return paymentResponseFromJson(response.body);
  }

  Future<PaymentResponse> authorizePayment(
    data,
  ) async {
    Uri url = Uri.parse("$shabelleAPI/authorizePayment");

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: data);
    print(response.body);

    return paymentResponseFromJson(response.body);
  }

  Future<ValidateAccountResponse> validateMobileMoney(
      String accountNumber, transactionAmount) async {
    var postBody = jsonEncode({
      "accountNumber": accountNumber,
      "transactionAmount": transactionAmount,
    });

    Uri url = Uri.parse("$shabelleAPI/validateMobileMoney");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);
    print(response.body);

    return validateAccountResponseFromJson(response.body);
  }

  Future<ValidateAccountResponse> validateBankAccount(
      String accountNumber, transactionAmount, bank) async {
    var postBody = jsonEncode({
      "accountNumber": accountNumber,
      "transactionAmount": transactionAmount,
      "bank": bank,
    });

    Uri url = Uri.parse("$shabelleAPI/validateBankAccount");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);
    print(response.body);

    return validateAccountResponseFromJson(response.body);
  }

  Future<ValidateAccountResponse> validatePayBillAccount(
      String accountNumber, transactionAmount, serviceName,
      {serviceProvider}) async {
    var postBody = jsonEncode({
      "accountNumber": accountNumber,
      "transactionAmount": transactionAmount,
      "serviceName": serviceName,
      "serviceProvider": serviceProvider,
    });

    Uri url = Uri.parse("$shabelleAPI/validatePayBillAccount");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);
    print(response.body);

    return validateAccountResponseFromJson(response.body);
  }

  Future<TransactionResponse> getTransactions(
    data,
  ) async {
    Uri url = Uri.parse("$shabelleAPI/getTransactions");

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: data);
    print(response.body);
    return transactionResponseFromJson(response.body);
  }

  Future<PaymentResponse> checkStatus(
    data,
  ) async {
    Uri url = Uri.parse("$shabelleAPI/checkStatus");

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: data);
    return paymentResponseFromJson(response.body);
  }
}
