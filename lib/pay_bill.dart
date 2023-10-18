import 'package:flutter/material.dart';
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/confirm_details.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/dashboard.dart';
import 'package:h_cash/input_decorations.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:h_cash/services/payment_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PayBill extends StatefulWidget {
  const PayBill(
    this.title,
    this.serviceName, {
    Key? key,
    this.labelText,
  }) : super(key: key);

  final String title, serviceName;
  final String? labelText;

  @override
  _PayBillState createState() => _PayBillState();
}

class _PayBillState extends State<PayBill> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _customerController = TextEditingController();
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
            child: CustomAppBar(widget.title, Icons.attach_money_outlined)),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: buildBody(),
        ));
  }

  Widget pageForm() {
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
                  widget.labelText ??
                      AppLocalizations.of(context)!.account_number,
                  style: TextStyle(
                      color: AppColors.greyColor2,
                      fontWeight: FontWeight.w300,
                      fontSize: 16),
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
                        controller: _customerController,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "2836000088"),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.serviceName != 'AIRTICKET',
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    AppLocalizations.of(context)!.amount,
                    style: TextStyle(
                        color: AppColors.greyColor2,
                        fontWeight: FontWeight.w300,
                        fontSize: 16),
                  ),
                ),
              ),
              Visibility(
                visible: widget.serviceName != 'AIRTICKET',
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
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
                              hint_text: "1000"),
                        ),
                      ),
                    ],
                  ),
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
                            fontWeight: FontWeight.w600),
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
            pageForm(),
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
    var account = _customerController.text.toString();
    var serviceName = widget.serviceName;
    var reason = widget.title;
    if (serviceName == 'AIRTICKET') {
      amount = '0';
    }
    if (amount == "") {
      showToast(context, AppLocalizations.of(context)!.enter_amount);
      return;
    } else if (account == "") {
      showToast(context, AppLocalizations.of(context)!.enter_phone);
      return;
    }

    loading();

    var validateResponse = await PaymentService().validatePayBillAccount(
        account, amount, serviceName,
        serviceProvider: widget.title);
    // ignore: use_build_context_synchronously
    Navigator.of(loadingContext!).pop();

    if (validateResponse.status != 'SUCCESS') {
      // ignore: use_build_context_synchronously
      showToast(context, validateResponse.message);
      return;
    } else {
      // ignore: use_build_context_synchronously
      showToast(context, validateResponse.message);
      // Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ConfirmDetails(
            validateResponse.accountNumber,
            user_phone.$,
            validateResponse.transactionAmount,
            reason,
            serviceName,
            user_name.$,
            validateResponse.accountName,
            '',
            '',
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
