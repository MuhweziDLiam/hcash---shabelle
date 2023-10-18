import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/input_decorations.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final nameController = TextEditingController(text: user_name.$);
  final phoneController = TextEditingController(text: user_phone.$);

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
            child: CustomAppBar(
                AppLocalizations.of(context)!
                    .main_screen_bottom_navigation_profile,
                Icons.person)),
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
                  AppLocalizations.of(context)!.profile_edit_screen_name,
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
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        readOnly: true,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "Allan Salim", icon: Icons.adb),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.order_details_screen_phone,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 36,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        readOnly: true,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "0700460065", icon: Icons.phone),
                      ),
                    ),
                  ],
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
            buildDescription(
                AppLocalizations.of(context)!
                    .main_screen_bottom_navigation_profile,
                description: AppLocalizations.of(context)!.profile_description),
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
