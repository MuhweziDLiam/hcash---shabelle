import 'package:h_cash/app_colors.dart';
import 'package:h_cash/box_decorations.dart';
import 'package:h_cash/coming_soon.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/device_info.dart';
import 'package:h_cash/marketplace/category_list.dart';
import 'package:h_cash/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:h_cash/pay_bill.dart';
import 'package:h_cash/qr_pay.dart';
import 'package:h_cash/telecoms.dart';
import 'package:h_cash/to_bank.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Bills extends StatefulWidget {
  Bills(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;
  @override
  _BillsState createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  final bool isMember = true;
  List _categories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () => getCategories());
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

  Widget buildDescription(String title,
      {String description =
          'Choose from our list of available bills avail the services in each.'}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              color: AppColors.greyColor2,
              fontSize: 25,
              height: 2,
              fontWeight: FontWeight.w300),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 8.0, bottom: 20, right: 8.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: MyTheme.font_grey,
                fontSize: 14,
                height: 1.6,
                fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }

  Widget buildBody(BuildContext context, String title, List _categories,
      {extraWidget}) {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          buildDescription(title,
              description: AppLocalizations.of(context)!.page_description),
          extraWidget ?? Container(),
          buildCategoryList(context, _categories),
        ]))
      ],
    );
  }

  Widget buildCategoryList(BuildContext context, List travelCategories) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.74,
        crossAxisCount: 3,
      ),
      itemCount: travelCategories.length,
      padding: EdgeInsets.only(left: 18, right: 18, bottom: 30, top: 10),
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return buildCategoryItemCard(context, travelCategories, index);
      },
    );
  }

  Widget buildCategoryItemCard(
      BuildContext context, List travelCategories, int index) {
    var itemWidth = ((DeviceInfo(context).width - 36) / 3);
    return Container(
      decoration: BoxDecorations.buildBoxDecoration_1(),
      child: Container(
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => travelCategories[index]['page'])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxHeight: itemWidth - 28),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      topLeft: Radius.circular(6)),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png',
                    image: travelCategories[index]['banner'],
                    fit: BoxFit.cover,
                    height: itemWidth,
                    width: DeviceInfo(context).width,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10.0),
                child: Text(
                  travelCategories[index]['name'],
                  // textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      color: AppColors.greyColor2,
                      // fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }

  getCategories() {
    var _list = [
      {
        "id": 1,
        "name": AppLocalizations.of(context)!.water,
        "banner":
            "https://www.oceancleanwash.org/wp-content/uploads/2019/09/Tapwater.jpg",
        "page": PayBill(AppLocalizations.of(context)!.water, 'WATER'),
      },
      {
        "id": 2,
        "name": AppLocalizations.of(context)!.electricity,
        "banner":
            "https://images.uncommongoods.com/images/items/55700/55715_1_640px.jpg",
        "description":
            "Please select this option if your recipient uses this bank",
        "page":
            PayBill(AppLocalizations.of(context)!.electricity, 'ELECTRICITY'),
      },
      {
        "id": 1,
        "name": AppLocalizations.of(context)!.airtime,
        "banner":
            "https://www.pngitem.com/pimgs/m/538-5383529_phone-call-png-phone-call-logo-transparent-png.png",
        "page": Telecoms(AppLocalizations.of(context)!.airtime),
      },
      {
        "id": 3,
        "name": AppLocalizations.of(context)!.pay_tv,
        "banner":
            "https://s.yimg.com/ny/api/res/1.2/uBhu4Qj0G7phbFUaVm4cwg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTY0MDtoPTQyNw--/https://media.zenfs.com/en/bgr_208/324bfebb5156434acdf6b35638208a16",
        "description":
            "Please select this option if your recipient uses this bank",
        "page": PayBill(AppLocalizations.of(context)!.pay_tv, 'PAYTV'),
      },
      {
        "id": 4,
        "name": AppLocalizations.of(context)!.school_fees,
        "banner":
            "https://bdhint.com/wp-content/uploads/2014/03/aboutuspreview.jpg",
        "description":
            "Please select this option if your recipient uses this bank",
        "page":
            PayBill(AppLocalizations.of(context)!.school_fees, 'SCHOOLFEES'),
      },
      // {
      //   "id": 3,
      //   "name": "QR Pay",
      //   "banner":
      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSenR1pk39r4AKmDXkYjiXB_bdDgD9pWU9iMg&usqp=CAU",
      //   "description":
      //       "Please select this option if your recipient uses this bank",
      //   "page": const QrPay('QR Pay'),
      // },
      // {
      //   "id": 4,
      //   "name": "Marketplace",
      //   "banner":
      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTR3keWMhuCLaljLOh8-3QVDJtyegSL8GAm5g&usqp=CAU",
      //   "description":
      //       "Please select this option if your recipient uses this bank",
      //   "page": CategoryList(
      //     is_base_category: true,
      //   ),
      // },
      // {
      //   "id": 3,
      //   "name": "Cardless ATM",
      //   "banner":
      //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVWGmelshu1r2XbcD_1G6RXsgAbxtiFZoYCg&usqp=CAU",
      //   "description":
      //       "Please select this option if your recipient uses this bank",
      //   "page": const ComingSoon('Cardless ATM'),
      // },
      // {
      //   "id": 4,
      //   "name": "Loans",
      //   "banner":
      //       "https://hips.hearstapps.com/hmg-prod/images/how-to-get-a-personal-loan-1584033069.jpg?crop=0.667xw:1.00xh;0.153xw,0&resize=1200:*",
      //   "description":
      //       "Please select this option if your recipient uses this bank",
      //   "page": const ComingSoon('Loans'),
      // },
      // {
      //   "id": 4,
      //   "name": "Savings",
      //   "banner":
      //       "https://naijapr.com/wp-content/uploads/2023/02/Saving-money.jpg",
      //   "description":
      //       "Please select this option if your recipient uses this bank",
      //   "page": const ComingSoon('Savings'),
      // },
    ];
    setState(() {
      _categories = _list;
    });
  }
}
