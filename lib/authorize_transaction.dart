import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/check_status.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/dashboard.dart';
import 'package:h_cash/failed.dart';
import 'package:h_cash/input_decorations.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:h_cash/secure_account.dart';
import 'package:h_cash/services/payment_services.dart';
import 'package:h_cash/success_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthorizeTransaction extends StatefulWidget {
  const AuthorizeTransaction(this.transactionReference, this.tranType,
      this.successStatus, this.appTransactionId,
      {Key? key})
      : super(key: key);
  final String transactionReference, tranType, successStatus, appTransactionId;
  @override
  State<AuthorizeTransaction> createState() => _AuthorizeTransactionState();
}

class _AuthorizeTransactionState extends State<AuthorizeTransaction> {
  final otpController = TextEditingController();
  BuildContext? loadingContext;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(screenWidth, 60),
          child: CustomAppBar(
              AppLocalizations.of(context)!.authorize_transaction,
              Icons.person)),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(5),
                    //     child: const Image(
                    //       image: AssetImage('assets/logo.png'),
                    //       height: 30,
                    //     ),
                    //   ),
                    // ),
                    Text(
                      AppLocalizations.of(context)!.authorize_transaction,
                      style: TextStyle(
                          color: AppColors.dashboardColor,
                          fontSize: 25,
                          height: 1,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!
                      .authorize_transaction_description,
                  style: TextStyle(
                      color: MyTheme.font_grey,
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Center(
                child: Image(
                  image: AssetImage('assets/otp.jpg'),
                  height: 300,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Text(
                  AppLocalizations.of(context)!.enter_code,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 36,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: otpController,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "123456", icon: Icons.pin),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: MediaQuery.of(context).size,
                        disabledBackgroundColor: MyTheme.grey_153,
                        //height: 50,
                        backgroundColor: MyTheme.accent_color,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Authorize Now',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                      ),
                      onPressed: () {
                        onSubmit();
                        // if (otpController.text != widget.otp) {
                        //   showToast(context, 'Please enter the correct OTP');
                        // } else {
                        //   showToast(
                        //       context, 'Transaction processed successfully');
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => HomePage('Home')));
                        // }
                      }),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  void onSubmit() async {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    var otp = otpController.text.toString();
    if (otp == "") {
      showToast(context, AppLocalizations.of(context)!.enter_code);
      return;
    }

    // showToast(context, 'Transaction completed successfully');
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    //   return const DashboardPage();
    // }));

    var tranReference = widget.transactionReference;
    var tranType = widget.tranType;
    var walletId = user_phone.$;

    Map rawData = {
      "otp": otp,
      "walletId": walletId,
      "tranType": tranType,
      "tranReference": tranReference,
    };
    var data = jsonEncode(rawData);

    loading();
    var authorizeResponse = await PaymentService().authorizePayment(data);
    Navigator.of(loadingContext!).pop();

    if (authorizeResponse.status != 'FAILED' &&
        authorizeResponse.status != 'FAIL') {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return CheckStatusPage(widget.appTransactionId);
      }));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const FailedPage();
      }));
    }

    // if (authorizeResponse.status != widget.successStatus) {
    //   // ignore: use_build_context_synchronously
    //   showToast(context, authorizeResponse.message);
    //   return;
    // } else {
    //   // ignore: use_build_context_synchronously
    //   showToast(context, authorizeResponse.message);
    //   if (widget.successStatus == 'SUCCESS') {
    //     // ignore: use_build_context_synchronously
    //     Navigator.pushReplacement(context,
    //         MaterialPageRoute(builder: (context) {
    //       return const SuccessPage();
    //     }));
    //   } else {
    //     // ignore: use_build_context_synchronously
    //     Navigator.pushReplacement(context,
    //         MaterialPageRoute(builder: (context) {
    //       return CheckStatusPage(widget.appTransactionId);
    //     }));
    //   }
    // }
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
}
