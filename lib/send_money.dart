import 'package:flutter/material.dart';
import 'package:h_cash/banks.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:h_cash/to_mobile.dart';
import 'package:h_cash/to_wallet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SendMoney extends StatefulWidget {
  const SendMoney(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;
  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  final bool isMember = true;
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
        "name": AppLocalizations.of(context)!.hcash_wallet,
        "banner":
            "https://img.freepik.com/free-vector/digital-wallet-abstract-concept-illustration_335657-3896.jpg?w=2000",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToWallet(AppLocalizations.of(context)!.hcash_wallet),
      },
      {
        "id": 16,
        "name": AppLocalizations.of(context)!.bank_account,
        "banner":
            "https://payveda.com/kcfinder/upload/images/Image-1%281%29.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": Banks(AppLocalizations.of(context)!.banks),
      },
      {
        "id": 10,
        "name": "Safaricom",
        "banner":
            "https://www.techinafrica.com/wp-content/uploads/2021/08/151.-safaricom.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": const ToMobile('Safaricom'),
      },
      {
        "id": 11,
        "name": "Telebirr",
        "banner":
            "https://ethiotelebirr.com/wp-content/uploads/2021/07/cropped-telebirr-logo.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": const ToMobile('Telebirr'),
      },
    ];
    setState(() {
      _categories = _list;
    });
  }
}
