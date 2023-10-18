import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/failed.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:h_cash/services/payment_services.dart';
import 'package:h_cash/success_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckStatusPage extends StatefulWidget {
  CheckStatusPage(this.appTransactionId, {Key? key}) : super(key: key);

  String appTransactionId;
  @override
  State<CheckStatusPage> createState() => _CheckStatusPageState();
}

class _CheckStatusPageState extends State<CheckStatusPage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) => checkStatus());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  checkStatus() async {
    var data = {'transactionId': widget.appTransactionId};
    var postData = jsonEncode(data);
    var statusResponse = await PaymentService().checkStatus(postData);
    if (statusResponse.finalStatus == 'PENDING' ||
        statusResponse.finalStatus == 'PROCESSING') {
      // ignore: use_build_context_synchronously
      showToast(context, statusResponse.message);
      return;
    } else if (statusResponse.finalStatus == 'SUCCESS') {
      // ignore: use_build_context_synchronously
      showToast(context, statusResponse.message);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const SuccessPage();
      }));
    } else {
      // ignore: use_build_context_synchronously
      showToast(context, statusResponse.message);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const FailedPage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size(screenWidth, 60),
          child: CustomAppBar(
              AppLocalizations.of(context)!.checking_status, Icons.person)),
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: const Image(
                          image: AssetImage('assets/logo.png'),
                          height: 30,
                        ),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.checking_status,
                      style: TextStyle(
                          color: AppColors.dashboardColor,
                          fontSize: 30,
                          height: 1,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.checking_status_description,
                  style: TextStyle(
                      color: MyTheme.font_grey,
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(height: 50),
              const SizedBox(
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                ),
              ),
              const Center(
                child: Image(
                  image: AssetImage('assets/loading.png'),
                  height: 250,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20.0),
              //   child: Container(
              //     height: 45,
              //     child: FlatButton(
              //         minWidth: MediaQuery.of(context).size.width,
              //         disabledColor: MyTheme.grey_153,
              //         //height: 50,
              //         color: MyTheme.accent_color,
              //         shape: const RoundedRectangleBorder(
              //             borderRadius: BorderRadius.all(Radius.circular(6.0))),
              //         child: const Text(
              //           'OK',
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 14,
              //               fontWeight: FontWeight.w300),
              //         ),
              //         onPressed: () {
              //           Navigator.pushReplacement(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => DashboardPage()));
              //         }),
              //   ),
              // ),
            ],
          ),
        ),
      )),
    );
  }
}
