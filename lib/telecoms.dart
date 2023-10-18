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
import 'package:h_cash/to_bank.dart';
import 'package:h_cash/withdraw.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Telecoms extends StatefulWidget {
  Telecoms(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;
  @override
  _TelecomsState createState() => _TelecomsState();
}

class _TelecomsState extends State<Telecoms> {
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
          'Choose from our list of available Telecoms avail the services in each.'}) {
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
        "id": 10,
        "name": "Safaricom",
        "banner":
            "https://www.techinafrica.com/wp-content/uploads/2021/08/151.-safaricom.png",
        "description": "Select this option to send money to a phone number",
        "page": PayBill(
          'Safaricom',
          'AIRTIME',
          labelText: AppLocalizations.of(context)!.phone_number,
        )
      },
      {
        "id": 11,
        "name": "Telebirr",
        "banner":
            "https://ethiotelebirr.com/wp-content/uploads/2021/07/cropped-telebirr-logo.png",
        "description": "Select this option to send money to a phone number",
        "page": PayBill(
          'Telebirr',
          'AIRTIME',
          labelText: AppLocalizations.of(context)!.phone_number,
        ),
      },
    ];
    setState(() {
      _categories = _list;
    });
  }
}
