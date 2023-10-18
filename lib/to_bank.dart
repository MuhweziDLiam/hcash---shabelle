import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/confirm_details.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/input_decorations.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:h_cash/services/payment_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ToBank extends StatefulWidget {
  ToBank(
    this.title, {
    Key? key,
    this.binNumber,
  }) : super(key: key);

  final String title;
  String? binNumber;
  @override
  _ToBankState createState() => _ToBankState();
}

class _ToBankState extends State<ToBank> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _accountController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _reasonController = TextEditingController();
  BuildContext? loadingContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(screenWidth, 60),
            child: CustomAppBar(widget.title, Icons.house)),
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
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  AppLocalizations.of(context)!.amount,
                  style: TextStyle(
                    color: AppColors.greyColor2,
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
                        controller: _amountController,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "1000", icon: Icons.money),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  AppLocalizations.of(context)!.account_number,
                  style: TextStyle(
                    color: AppColors.greyColor2,
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
                        controller: _accountController,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "089008", icon: Icons.numbers_rounded),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  AppLocalizations.of(context)!.narration,
                  style: TextStyle(
                    color: AppColors.greyColor2,
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
                        keyboardType: TextInputType.text,
                        controller: _reasonController,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "Rent for March", icon: Icons.abc),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
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
                      child: Text(
                        AppLocalizations.of(context)!.submit,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                      ),
                      onPressed: () {
                        onSubmit();
                      }),
                ),
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
            buildDescription(widget.title,
                description: AppLocalizations.of(context)!.form_description),
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

    var amount = _amountController.text.toString();
    var account = _accountController.text.toString();
    // var name = _nameController.text.toString();
    var reason = _reasonController.text.toString();
    var serviceName = 'BANK_TRANSFERS';
    var bankName = widget.binNumber ?? widget.title;
    if (amount == "") {
      showToast(context, AppLocalizations.of(context)!.enter_amount);
      return;
    } else if (account == "") {
      showToast(context, AppLocalizations.of(context)!.enter_phone);
      return;
      // } else if (name == "") {
      //   showToast(context, 'Please enter recipient name');
      //   return;
    } else if (reason == "") {
      showToast(context, AppLocalizations.of(context)!.enter_narration);
      return;
    }
    loading();
    print(bankName);

    var validateResponse =
        await PaymentService().validateBankAccount(account, amount, bankName);
    // ignore: use_build_context_synchronously
    Navigator.of(loadingContext!).pop();

    if (validateResponse.status != 'SUCCESS') {
      // ignore: use_build_context_synchronously
      showToast(context, validateResponse.message);
      return;
    } else {
      print(validateResponse.tranCharge);
      // ignore: use_build_context_synchronously
      showToast(context, validateResponse.message);
      // Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ConfirmDetails(
            validateResponse.accountNumber,
            user_phone.$,
            amount,
            reason,
            serviceName,
            user_name.$,
            validateResponse.accountName,
            validateResponse.accountParticulars,
            bankName,
            validateResponse.tranCharge);
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
}
