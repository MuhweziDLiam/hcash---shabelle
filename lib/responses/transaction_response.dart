import 'dart:convert';

TransactionResponse transactionResponseFromJson(String str) =>
    TransactionResponse.fromJson(json.decode(str));

// String transactionResponseToJson(TransactionResponse data) =>
//     json.encode(data.toJson());

class TransactionResponse {
  TransactionResponse(this.status, this.message, this.transactions);

  final String status, message;
  final List<Transaction> transactions;

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      TransactionResponse(
        json["status"],
        json["message"] ?? '',
        List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //       "status": status,
  //       "message": message,
  //       "transactionId": transactionId,
  //     };
}

class Transaction {
  DateTime date;
  String amount;
  String serviceName;
  String recipient;
  String sender;
  String toAccount;
  String fromAccount;
  String transactionReference;
  String transactionStatus;
  String transactionCharge;

  Transaction({
    required this.date,
    required this.amount,
    required this.serviceName,
    required this.recipient,
    required this.sender,
    required this.toAccount,
    required this.fromAccount,
    required this.transactionReference,
    required this.transactionStatus,
    required this.transactionCharge,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        date: DateTime.parse(json["processed_date"]),
        amount: json["from_amount"],
        serviceName: json["service_name"],
        recipient: json["recepient_name"],
        sender: json["sender_name"],
        toAccount: json["to_account"],
        fromAccount: json["from_account"],
        transactionReference: json["app_reference"],
        transactionStatus: json["tran_status"],
        transactionCharge: json["biller_charge"],
      );
}
