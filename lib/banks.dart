import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:flutter/material.dart';
import 'package:h_cash/to_bank.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Banks extends StatefulWidget {
  Banks(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;
  @override
  _BanksState createState() => _BanksState();
}

class _BanksState extends State<Banks> {
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
        "id": 2,
        "name": "Bunna International Bank",
        "banner":
            "https://bunnabanksc.com/wp-content/uploads/2021/11/BunnaBankLogo.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Bunna International Bank',
          binNumber: '231414',
        ),
      },
      {
        "id": 8,
        "name": "Shabelle Bank",
        "banner":
            "https://addisbiz.com/wp-content/uploads/Shabelle-Bank-Ethiopia.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank('Shabelle Bank'),
      },
      {
        "id": 9,
        "name": "Commercial Bank of Ethiopia",
        "banner":
            "https://www.capitalethiopia.com/wp-content/uploads/2021/02/CBE.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank('Commercial Bank of Ethiopia', binNumber: '231402'),
      },
      {
        "id": 11,
        "name": "Awash International Bank",
        "banner":
            "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Awash_Bank_Final_logo.jpg/1200px-Awash_Bank_Final_logo.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Awash International Bank',
          binNumber: '231404',
        ),
      },
      {
        "id": 16,
        "name": "Dashen Bank",
        "banner":
            "https://i0.wp.com/www.islamicfinancenews.com/wp-content/uploads/2018/02/CF_1507.jpg?fit=1024%2C768&ssl=1",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Dashen Bank',
          binNumber: '231405',
        ),
      },
      {
        "id": 16,
        "name": "Bank Of Abyssinia",
        "banner":
            "https://banksethiopia.com/wp-content/uploads/2020/10/abyssinia-bank-logo-profit-financial-statement-shareholder-768x576.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Bank Of Abyssinia',
          binNumber: '231406',
        ),
      },
      {
        "id": 16,
        "name": "Wegagen Bank",
        "banner":
            "https://upload.wikimedia.org/wikipedia/commons/c/ca/Wogagen_Bank.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Wegagen Bank',
          binNumber: '231407',
        ),
      },
      {
        "id": 16,
        "name": "Hibret Bank",
        "banner":
            "https://www.ethiopiansharemarket.com/images/share/United-Bank-Ethiopia.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Hibret Bank',
          binNumber: '231408',
        ),
      },
      {
        "id": 16,
        "name": "Nib International Bank",
        "banner":
            "https://sabiet.com/jobs/icons/2716f6b6e99d458c91616835d8b903bf.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Nib International Bank',
          binNumber: '231409',
        ),
      },
      {
        "id": 16,
        "name": "Cooperative Bank of Oromia",
        "banner":
            "https://coopbankoromia.com.et/wp-content/uploads/2021/12/Cooperative_Bank_of_Oromia.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Cooperative Bank of Oromia',
          binNumber: '231410',
        ),
      },
      {
        "id": 16,
        "name": "Zemen Bank",
        "banner": "https://www.zemenbank.com/images/assets/logo2x.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Zemen Bank',
          binNumber: '231412',
        ),
      },
      {
        "id": 16,
        "name": "Berhan International Bank",
        "banner": "https://myaksion.com/wp-content/uploads/2017/10/bib.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Berhan International Bank',
          binNumber: '231415',
        ),
      },
      {
        "id": 16,
        "name": "Abay Bank",
        "banner":
            "https://www.capitalethiopia.com/wp-content/uploads/2022/11/Abay.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Abay Bank',
          binNumber: '231416',
        ),
      },
      {
        "id": 16,
        "name": "Enat Bank",
        "banner":
            "https://play-lh.googleusercontent.com/cz0nw1gJiaCxkVkAYqSlpF2dswxieduz4CRPaeh2vq7VSBRERHi1hMNDoDNywx1JgPY",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Enat Bank',
          binNumber: '231419',
        ),
      },
      {
        "id": 16,
        "name": "CBE Birr",
        "banner":
            "https://play-lh.googleusercontent.com/rcSKabjkP2GfX1_I_VXBfhQIPdn_HPXj5kbkDoL4cu5lpvcqPsGmCqfqxaRrSI9h5_A",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'CBE Birr',
          binNumber: '231439',
        ),
      },
      {
        "id": 16,
        "name": "Amhara Bank",
        "banner":
            "https://banksethiopia.com/wp-content/uploads/amhara-e1687511691185.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Amhara Bank',
          binNumber: '231448',
        ),
      },
      {
        "id": 16,
        "name": "Tsehay Bank",
        "banner":
            "https://tsehaybank.com.et/wp-content/uploads/2023/06/Tsehay-Bank-Share-Company-Logo.jpg.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Tsehay Bank',
          binNumber: '231432',
        ),
      },
      {
        "id": 16,
        "name": "Debub Global Bank",
        "banner":
            "https://www.capitalethiopia.com/wp-content/uploads/2020/01/debub-Global.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Debub Global bank',
          binNumber: '231418',
        ),
      },
      {
        "id": 16,
        "name": "Ahadu Global Bank",
        "banner":
            "https://banksethiopia.com/wp-content/uploads/ahadu-logo.jpeg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Ahadu Global Bank',
          binNumber: '231431',
        ),
      },
      {
        "id": 16,
        "name": "Goh Betoch Bank",
        "banner":
            "https://www.gohbetbank.com/wp-content/uploads/2022/12/mobile.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Goh Betoch Bank',
          binNumber: '231444',
        ),
      },
      {
        "id": 16,
        "name": "Hijira Bank",
        "banner":
            "https://theme.zdassets.com/theme_assets/12073024/2f39f5e7f8829cc366c312f809dc888466167a84.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Hijira Bank',
          binNumber: '231427',
        ),
      },
      {
        "id": 16,
        "name": "ZamZam Bank",
        "banner": "https://zamzambank.com/wp-content/uploads/2021/05/logo.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'ZamZam Bank',
          binNumber: '231428',
        ),
      },
      {
        "id": 16,
        "name": "Oromia Bank",
        "banner":
            "https://upload.wikimedia.org/wikipedia/commons/8/88/Oromia_bank.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Oromia Bank',
          binNumber: '231413',
        ),
      },
      {
        "id": 16,
        "name": "Lion Bank",
        "banner":
            "https://anbesabank.com/wp-content/themes/lion-international-bank/assets/img/logo.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Lion Bank',
          binNumber: '231443',
        ),
      },
      {
        "id": 16,
        "name": "Addis International Bank",
        "banner":
            "https://banksethiopia.com/wp-content/uploads/2020/12/21370834_296269067447274_1806288827891586186_n.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Addis International Bank',
          binNumber: '231417',
        ),
      },
      {
        "id": 16,
        "name": "Kacha DFS",
        "banner":
            "https://www.capitalethiopia.com/wp-content/uploads/2022/07/kacha.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Kacha DFS',
          binNumber: '231442',
        ),
      },
      {
        "id": 16,
        "name": "Tseday Bank",
        "banner":
            "https://tsedeybank-sc.com/wp-content/uploads/2023/02/photo_2023-02-03-09.26.07-PhotoRoom.png-PhotoRoom.png",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Tseday Bank',
          binNumber: '231456',
        ),
      },
      {
        "id": 16,
        "name": "Vision MFI Bank",
        "banner":
            "https://www.visionfundmfi.com/wp-content/uploads/2019/10/Logo-55.jpg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Vision MFI Bank',
          binNumber: '231445',
        ),
      },
      {
        "id": 16,
        "name": "Gadaa Bank",
        "banner":
            "https://dereja-filestorage-prod.s3.eu-central-1.amazonaws.com/public/jobs/555/QGy8Ng9dqWui2veUMgKJrHIQcyVwDBdW0jI2jSZD.jpeg",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Gadaa Bank',
          binNumber: '231457',
        ),
      },
      {
        "id": 16,
        "name": "Siinqe Bank",
        "banner":
            "https://i0.wp.com/ethiopianstoday.com/wp-content/uploads/2022/03/Siinqee-Bank.jpg?fit=1000%2C500&ssl=1&resize=350%2C200",
        "description": AppLocalizations.of(context)!.option_description,
        "page": ToBank(
          'Siinqe Bank',
          binNumber: '231430',
        ),
      },
    ];
    setState(() {
      _categories = _list;
    });
  }
}
