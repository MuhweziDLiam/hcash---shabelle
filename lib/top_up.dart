import 'package:flutter/material.dart';
import 'package:h_cash/banks.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/deposit.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:h_cash/to_mobile.dart';
import 'package:h_cash/to_wallet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopUp extends StatefulWidget {
  const TopUp(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;
  @override
  _TopUpState createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  List _categories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(screenWidth, 60),
            child: CustomAppBar(widget.title, Icons.send)),
        body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: buildBody(context, widget.title, _categories)));
  }

  getCategories() {
    var _list = [
      {
        "id": 9,
        "name": AppLocalizations.of(context)!.from_mobile,
        "banner":
            "https://pbs.twimg.com/profile_images/414716085464604672/cWAf2zp4_400x400.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": DepositPage(AppLocalizations.of(context)!.from_mobile, false),
      },
      {
        "id": 16,
        "name": AppLocalizations.of(context)!.from_card,
        "banner":
            "https://pctechmag.com/wp-content/uploads/2015/11/Debit-Cards.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": DepositPage(AppLocalizations.of(context)!.from_card, true),
      },
      {
        "id": 16,
        "name": AppLocalizations.of(context)!.from_bank,
        "banner":
            "https://payveda.com/kcfinder/upload/images/Image-1%281%29.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": DepositPage(AppLocalizations.of(context)!.from_bank, false),
      },
    ];
    setState(() {
      _categories = _list;
    });
  }
}
