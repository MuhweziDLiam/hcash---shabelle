import 'dart:convert';

ValidateAccountResponse validateAccountResponseFromJson(String str) =>
    ValidateAccountResponse.fromJson(json.decode(str));

String validateAccountResponseToJson(ValidateAccountResponse data) =>
    json.encode(data.toJson());

class ValidateAccountResponse {
  ValidateAccountResponse(
    this.status,
    this.message,
    this.walletId,
    this.name,
    this.balance,
    this.accountNumber,
    this.accountName,
    this.tranCharge,
    this.transactionAmount,
    this.accountParticulars,
  );

  final String status,
      message,
      walletId,
      name,
      balance,
      accountNumber,
      accountName,
      tranCharge,
      transactionAmount,
      accountParticulars;

  factory ValidateAccountResponse.fromJson(Map<String, dynamic> json) =>
      ValidateAccountResponse(
        json["status"],
        json["message"] ?? '',
        json["walletId"] ?? '',
        json["name"] ?? '',
        json["balance"] ?? '',
        json["accountNumber"] ?? '',
        json["accountName"] ?? '',
        json["tranCharge"] ?? '0',
        json["transactionAmount"] ?? '0',
        json["accountParticulars"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
