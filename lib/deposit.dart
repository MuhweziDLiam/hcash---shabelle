import 'package:flutter/material.dart';
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/confirm_details.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/dashboard.dart';
import 'package:h_cash/input_decorations.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DepositPage extends StatefulWidget {
  const DepositPage(
    this.title,
    this.isCard, {
    Key? key,
  }) : super(key: key);

  final String title;
  final bool isCard;

  @override
  _DepositPageState createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _cardController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  BuildContext? loadingcontext;

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
            child: CustomAppBar(widget.title, Icons.card_membership)),
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
                  AppLocalizations.of(context)!.amount,
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
              Visibility(
                visible: widget.isCard,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        AppLocalizations.of(context)!.card_number,
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
                              keyboardType: TextInputType.number,
                              controller: _cardController,
                              autofocus: false,
                              decoration:
                                  InputDecorations.buildInputDecoration_1(
                                      hint_text: "1000"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.isCard,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        'CVV / CVC',
                        style: TextStyle(
                            color: AppColors.greyColor2,
                            fontWeight: FontWeight.w300,
                            fontSize: 16),
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
                              controller: _cvvController,
                              autofocus: false,
                              decoration:
                                  InputDecorations.buildInputDecoration_1(
                                      hint_text: "1000"),
                            ),
                          ),
                        ],
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

    var amount = _amountController.text;
    var narration = 'Mobile money top up';
    var serviceName = 'MOMO_TOPUP';
    if (amount == '') {
      showToast(context, 'Please enter the amount');
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ConfirmDetails(user_phone.$, user_phone.$, amount, narration,
          serviceName, user_name.$, user_name.$, '', '', '100');
    }));

    // var amount = _amountController.text.toString();
    // var serviceName = 'MOMO_TOPUP';
    // String transactionId = DateTime.now().millisecondsSinceEpoch.toString();
    // transactionId = transactionId + user_name.$;

    // if (amount == "") {
    //   ToastComponent.showDialog('Please enter the amount',
    //       gravity: Toast.center, duration: Toast.lengthLong);
    //   return;
    // }
    // loading('Please wait...');

    // var topUpResponse = await PaymentRepository().transactionResponse(
    //     user_phone.$,
    //     account_number.$,
    //     amount,
    //     serviceName,
    //     account_number.$,
    //     user_phone.$,
    //     user_name.$,
    //     user_name.$,
    //     transactionId);

    // if (topUpResponse.status != 'PENDING') {
    //   Navigator.of(loadingcontext).pop();
    //   ToastComponent.showDialog(topUpResponse.message,
    //       gravity: Toast.center, duration: Toast.lengthLong);
    // } else {
    //   return new Future.delayed(const Duration(seconds: 10), () {
    //     _checkStatus(transactionId);
    //   });
    // }
  }

  // _checkStatus(String transactionId) async {
  //   var statusResponse =
  //       await PaymentRepository().transactionStatusResponse(transactionId);
  //   if (statusResponse.finalStatus == 'SUCCESS') {
  //     Navigator.of(loadingcontext).pop();
  //     ToastComponent.showDialog(statusResponse.message,
  //         gravity: Toast.center, duration: Toast.lengthLong);

  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
  //       return ProcessCompleted(
  //         description:
  //             'Congratulations, your transaction was processed successfully!',
  //       );
  //     }));
  //   } else if (statusResponse.finalStatus == 'PROCESSING' ||
  //       statusResponse.finalStatus == 'PENDING') {
  //     return new Future.delayed(const Duration(seconds: 10), () {
  //       _checkStatus(transactionId);
  //     });
  //   } else {
  //     Navigator.of(loadingcontext).pop();
  //     ToastComponent.showDialog(statusResponse.message,
  //         gravity: Toast.center, duration: Toast.lengthLong);
  //   }
  // }

  loading(String loadingText) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          loadingcontext = context;
          return AlertDialog(
              content: Row(
            children: [
              CircularProgressIndicator(color: MyTheme.accent_color),
              SizedBox(
                width: 10,
              ),
              Text(loadingText),
            ],
          ));
        });
  }
}
