import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/input_decorations.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QrPage extends StatefulWidget {
  const QrPage(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
            child: CustomAppBar(widget.title, Icons.qr_code_2)),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: buildBody(),
        ));
  }

  Widget creditForm() {
    return Center(
      child: QrImage(
        data: user_phone.$,
        version: QrVersions.auto,
        size: 500.0,
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildDescription(widget.title,
                description: AppLocalizations.of(context)!.my_code_description),
            creditForm(),
          ],
        ),
      ),
    );
  }

  // onSubmit() async {
  //   var amount = _amountController.text.toString();
  //   var account = _accountController.text.toString();
  //   var serviceName = 'WALLET_TO_WALLET';
  //   String transactionId = DateTime.now().millisecondsSinceEpoch.toString();
  //   transactionId = transactionId + user_name.$;

  //   if (amount == "") {
  //     ToastComponent.showDialog('Please enter the amount',
  //         gravity: Toast.center, duration: Toast.lengthLong);
  //     return;
  //   } else if (account == "") {
  //     ToastComponent.showDialog(
  //         'Please enter a wallet account you want to send to',
  //         gravity: Toast.center,
  //         duration: Toast.lengthLong);
  //     return;
  //   }
  //   // loading();
  //   loading();
  //   var transactionResponse = await PaymentRepository().transactionResponse(
  //       account_number.$,
  //       account,
  //       amount,
  //       serviceName,
  //       account_number.$,
  //       user_phone.$,
  //       user_name.$,
  //       user_name.$,
  //       transactionId);
  //   Navigator.of(loadingcontext).pop();

  //   if (transactionResponse.status != 'RECEIVED') {
  //     ToastComponent.showDialog(transactionResponse.message,
  //         gravity: Toast.center, duration: Toast.lengthLong);
  //   } else {
  //     ToastComponent.showDialog(transactionResponse.message,
  //         gravity: Toast.center, duration: Toast.lengthLong);
  //     Navigator.push(context, MaterialPageRoute(builder: (context) {
  //       return TransactionOTP(
  //         title: 'Enter OTP',
  //         transactionReference: transactionResponse.transactionId,
  //         tranType: serviceName,
  //       );
  //     }));
  //   }
  // }

  // loading() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         loadingcontext = context;
  //         return AlertDialog(
  //             content: Row(
  //           children: [
  //             CircularProgressIndicator(),
  //             SizedBox(
  //               width: 10,
  //             ),
  //             Text("${AppLocalizations.of(context).loading_text}"),
  //           ],
  //         ));
  //       });
  // }
}
