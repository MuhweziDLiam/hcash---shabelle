import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:flutter/material.dart';
import 'package:h_cash/pay_bill.dart';
import 'package:h_cash/to_bank.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Airlines extends StatefulWidget {
  Airlines(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;
  @override
  _AirlinesState createState() => _AirlinesState();
}

class _AirlinesState extends State<Airlines> {
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
            child: CustomAppBar(widget.title, Icons.house)),
        body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: buildBody(context, widget.title, _categories)));
  }

  getCategories() {
    var _list = [
      {
        "id": 1,
        "name": "Qatar Airways",
        "banner":
            "https://curlytales.com/wp-content/uploads/2023/06/Qatar-Airways.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": PayBill('Qatar Airways', 'AIRTICKET',
            labelText: AppLocalizations.of(context)!.pnr),
      },
      {
        "id": 1,
        "name": "Fly Dubai",
        "banner":
            "https://apa.az/storage/news/2023/april/24/big/6446ba427bf236446ba427bf2416823568026446ba427bf1f6446ba427bf21.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": PayBill('Fly Dubai', 'AIRTICKET',
            labelText: AppLocalizations.of(context)!.pnr),
      },
      {
        "id": 1,
        "name": "Saudia Airlines",
        "banner":
            "https://www.arabnews.com/sites/default/files/styles/n_670_395/public/2021/04/12/2568721-1220162045.jpg?itok=bjCt5ZcW",
        "description": AppLocalizations.of(context)!.option_description,
        "page": PayBill('Saudia Airlines', 'AIRTICKET',
            labelText: AppLocalizations.of(context)!.pnr),
      },
      {
        "id": 1,
        "name": "Turkish Airlines",
        "banner":
            "https://i0.wp.com/airinsight.com/wp-content/uploads/2022/08/1659313917439.jpg?fit=800%2C331&ssl=1",
        "description": AppLocalizations.of(context)!.option_description,
        "page": PayBill('Turkish Airlines', 'AIRTICKET',
            labelText: AppLocalizations.of(context)!.pnr),
      },
      {
        "id": 1,
        "name": "Gulf Air",
        "banner":
            "https://www.travelnewsasia.com/newspics/2022/GulfAirDreamliner7879.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": PayBill('Gulf Air', 'AIRTICKET',
            labelText: AppLocalizations.of(context)!.pnr),
      },
      {
        "id": 1,
        "name": "Lufthansa",
        "banner":
            "https://www.nerdwallet.com/assets/blog/wp-content/uploads/2023/01/20221016_787_BRE_012.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": PayBill('Lufthansa', 'AIRTICKET',
            labelText: AppLocalizations.of(context)!.pnr),
      },
      {
        "id": 1,
        "name": "Emirates",
        "banner":
            "https://www.nerdwallet.com/assets/blog/wp-content/uploads/2022/11/image4-7-1440x864.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": PayBill('Emirates', 'AIRTICKET',
            labelText: AppLocalizations.of(context)!.pnr),
      },
      {
        "id": 1,
        "name": "Egyptair",
        "banner":
            "https://media.istockphoto.com/id/531423754/photo/egyptair-a320-taking-off.jpg?s=612x612&w=0&k=20&c=860At5wVXbF-qeAEjDoXXdPF8TfdsalMPbrN3hcBH-I=",
        "description": AppLocalizations.of(context)!.option_description,
        "page": PayBill('Egyptair', 'AIRTICKET',
            labelText: AppLocalizations.of(context)!.pnr),
      },
      {
        "id": 1,
        "name": "Ethiopian Airways",
        "banner":
            "https://i0.wp.com/airinsight.com/wp-content/uploads/2021/09/Ethiopian.jpg?fit=2238%2C906&ssl=1",
        "description": AppLocalizations.of(context)!.option_description,
        "page": PayBill('Ethiopian Airways', 'AIRTICKET',
            labelText: AppLocalizations.of(context)!.pnr),
      },
      {
        "id": 1,
        "name": "Kenya Airways",
        "banner":
            'https://s28477.pcdn.co/wp-content/uploads/2017/10/Kenya_1-984x554.jpg',
        "description": AppLocalizations.of(context)!.option_description,
        "page": PayBill('Kenya Airways', 'AIRTICKET',
            labelText: AppLocalizations.of(context)!.pnr),
      },
    ];
    setState(() {
      _categories = _list;
    });
  }
}
