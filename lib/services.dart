import 'package:h_cash/app_colors.dart';
import 'package:h_cash/box_decorations.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/device_info.dart';
import 'package:h_cash/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:h_cash/pay_bill.dart';
import 'package:h_cash/to_bank.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Services extends StatefulWidget {
  Services(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  final bool isMember = true;
  List _categories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategories();
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
          'Choose from our list of available Services avail the services in each.'}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              color: AppColors.dashboardColor,
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
          buildDescription(title),
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
                      color: AppColors.dashboardColor,
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
        "name": "Buy Airtime",
        "banner":
            "https://www.oceancleanwash.org/wp-content/uploads/2019/09/Tapwater.jpg",
        "page": PayBill('Pay Water Bill', 'WATER'),
      },
      {
        "id": 2,
        "name": "Pay Air Ticket",
        "banner":
            "https://images.uncommongoods.com/images/items/55700/55715_1_640px.jpg",
        "description":
            "Please select this option if your recipient uses this bank",
        "page": PayBill('Pay Electricity Bill', 'ELECTRICITY'),
      },
      {
        "id": 3,
        "name": AppLocalizations.of(context)!.pay_taxi,
        "banner":
            "https://s.yimg.com/ny/api/res/1.2/uBhu4Qj0G7phbFUaVm4cwg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTY0MDtoPTQyNw--/https://media.zenfs.com/en/bgr_208/324bfebb5156434acdf6b35638208a16",
        "description":
            "Please select this option if your recipient uses this bank",
        "page": PayBill('Pay TV Bill', ''),
      },
      // {
      //   "id": 4,
      //   "name": "School Fees",
      //   "banner":
      //       "https://bdhint.com/wp-content/uploads/2014/03/aboutuspreview.jpg",
      //   "description":
      //       "Please select this option if your recipient uses this bank",
      //   "page": PayBill('Pay School Fees'),
      // },
      // {
      //   "id": 5,
      //   "name": "Airtime & Internet",
      //   "banner":
      //       "https://cdn-hkaph.nitrocdn.com/zORRWebHlWLpduzYFnZuJsYtjOJnQQpk/assets/images/optimized/rev-cff1feb/blog/wp-content/uploads/sites/3/2019/10/mobile-apps-in-business-copy-5.jpg",
      //   "description":
      //       "Please select this option if your recipient uses this bank",
      //   "page": const PayBill('Buy Airtime & Internet'),
      // },
    ];
    setState(() {
      _categories = _list;
    });
  }
}
