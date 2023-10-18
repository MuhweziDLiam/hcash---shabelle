import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/authorize_transaction.dart';
import 'package:h_cash/check_status.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/input_decorations.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:h_cash/services/payment_services.dart';
import 'package:h_cash/to_wallet.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmDetails extends StatefulWidget {
  const ConfirmDetails(
    this.toAccount,
    this.fromAccount,
    this.transactionAmount,
    this.narration,
    this.serviceName,
    this.senderName,
    this.receiverName,
    this.accountParticulars,
    this.title,
    this.transactionCharge, {
    Key? key,
  }) : super(key: key);

  final String toAccount,
      fromAccount,
      transactionAmount,
      narration,
      serviceName,
      senderName,
      receiverName,
      accountParticulars,
      title,
      transactionCharge;
  @override
  _ConfirmDetailsState createState() => _ConfirmDetailsState();
}

class _ConfirmDetailsState extends State<ConfirmDetails> {
  final receiverNameController = TextEditingController();
  final toAccountController = TextEditingController();
  final transactionAmountController = TextEditingController();
  final transactionChargeController = TextEditingController();
  BuildContext? loadingContext;
  String successStatus = '';
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  final LocalAuthentication auth = LocalAuthentication();
  bool biometricsEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toAccountController.text = widget.toAccount;
    receiverNameController.text = widget.receiverName;
    transactionAmountController.text = widget.transactionAmount;
    transactionChargeController.text = widget.transactionCharge;
    getSuccessStatus();
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Please complete verification to login to the application',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }
    if (authenticated) onSubmit();
  }

  checkIfBiometrics() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      biometricsEnabled = prefs.getBool('biometricsEnabled') ?? false;
    });

    if (biometricsEnabled) {
      _authenticateWithBiometrics();
    } else {
      onSubmit();
    }
  }

  getSuccessStatus() {
    print(widget.serviceName);
    if (widget.serviceName != 'WALLET_TO_WALLET' &&
        widget.serviceName != 'TAXI' &&
        widget.serviceName != 'AIRTICKET' &&
        widget.serviceName != 'WALLET_SCAN_TO_PAY') {
      successStatus = 'PENDING';
    } else {
      successStatus = 'SUCCESS';
    }
    print(successStatus);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(screenWidth, 60),
            child: CustomAppBar(
                AppLocalizations.of(context)!.confirm_details, Icons.person)),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: buildBody(),
        ));
  }

  Widget creditForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.recipient_name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 36,
                      child: TextField(
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        controller: receiverNameController,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            icon: Icons.adb),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.account_number,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 36,
                      child: TextField(
                        readOnly: true,
                        keyboardType: TextInputType.phone,
                        controller: toAccountController,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            icon: Icons.adb),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.amount,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 36,
                      child: TextField(
                        readOnly: true,
                        keyboardType: TextInputType.phone,
                        controller: transactionAmountController,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            icon: Icons.adb),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.transaction_charge,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 36,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: transactionChargeController,
                        readOnly: true,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            icon: Icons.ac_unit),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: MediaQuery.of(context).size / 2.5,
                            disabledBackgroundColor: MyTheme.grey_153,
                            //height: 50,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                          onPressed: () {
                            onBack();
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: MediaQuery.of(context).size / 2.5,
                            disabledBackgroundColor: MyTheme.grey_153,
                            //height: 50,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Confirm ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                          onPressed: () {
                            checkIfBiometrics();
                          }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildDescription(AppLocalizations.of(context)!.confirm_details,
                description:
                    AppLocalizations.of(context)!.confirm_details_description),
            creditForm(),
          ],
        ),
      ),
    );
  }

  onSubmit() async {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    loading();
    var paymentResponse = await PaymentService().paymentResponse(
        widget.toAccount,
        widget.fromAccount,
        widget.transactionAmount,
        widget.narration,
        widget.serviceName,
        widget.senderName,
        widget.receiverName,
        widget.accountParticulars,
        widget.title,
        widget.transactionCharge);
    Navigator.of(loadingContext!).pop();
    print(paymentResponse.status);
    if (paymentResponse.status == 'FAIL') {
      // ignore: use_build_context_synchronously
      showToast(context, paymentResponse.message);
    } else if (paymentResponse.status == 'PENDING') {
      // ignore: use_build_context_synchronously
      showToast(context, paymentResponse.message);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return CheckStatusPage(paymentResponse.appTransactionId);
      }));
    } else if (paymentResponse.status == 'RECEIVED' &&
        widget.serviceName == 'CASH_OUT') {
      // ignore: use_build_context_synchronously
      showToast(context, paymentResponse.message);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return CheckStatusPage(paymentResponse.appTransactionId);
      }));
    } else {
      // ignore: use_build_context_synchronously
      showToast(context, paymentResponse.message);
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AuthorizeTransaction(
          paymentResponse.transactionId,
          widget.serviceName,
          successStatus,
          paymentResponse.appTransactionId,
        );
      }));
    }
  }

  loading() {
    showDialog(
        context: context,
        builder: (context) {
          loadingContext = context;
          return AlertDialog(
              content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 10,
              ),
              Text(AppLocalizations.of(context)!.loading_text),
            ],
          ));
        });
  }

  void onBack() {
    Navigator.pop(context);
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    //   return ToWallet(
    //     'To Wallet',
    //   );
    // }));
  }
}
