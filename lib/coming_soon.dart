import 'package:flutter/material.dart';
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/confirm_details.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/dashboard.dart';
import 'package:h_cash/input_decorations.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:h_cash/services/payment_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  _ComingSoonState createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
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
          child: Center(child: buildBody()),
        ));
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildDescription(AppLocalizations.of(context)!.coming_soon,
                description:
                    AppLocalizations.of(context)!.coming_soon_description),
          ],
        ),
      ),
    );
  }
}
