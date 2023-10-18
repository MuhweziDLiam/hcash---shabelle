import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:h_cash/airlines.dart';
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/auth_helper.dart';
import 'package:h_cash/bills.dart';
import 'package:h_cash/biometric_auth.dart';
import 'package:h_cash/change_password.dart';
import 'package:h_cash/coming_soon.dart';
import 'package:h_cash/contact_us.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/deposit.dart';
import 'package:h_cash/login_page.dart';
import 'package:h_cash/marketplace/cart_counter.dart';
import 'package:h_cash/marketplace/category_products.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/marketplace/shimmer_helper.dart';
import 'package:h_cash/marketplace/sliders_repository.dart';
import 'package:h_cash/marketplace/web_page.dart';
import 'package:h_cash/my_preferences.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/others.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:h_cash/pay_bill.dart';
import 'package:h_cash/pay_merchant.dart';
import 'package:h_cash/pay_options.dart';
import 'package:h_cash/qr_page.dart';
import 'package:h_cash/qr_pay.dart';
import 'package:h_cash/send_money.dart';
import 'package:h_cash/services/auth_services.dart';
import 'package:h_cash/telecoms.dart';
import 'package:h_cash/top_up.dart';
import 'package:h_cash/transactions.dart';
import 'package:h_cash/withdraw.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FrontPage extends StatefulWidget {
  const FrontPage(this.title, this.counter, {Key? key}) : super(key: key);

  final String title;
  final CartCounter counter;

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  bool isMasked = true;
  NumberFormat formatter = NumberFormat.decimalPattern('en_us');
  var _carouselImageList = [];
  bool _isCarouselInitial = true;
  int _current_slider = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCarouselImages();
  }

  fetchCarouselImages() async {
    var carouselResponse = await SlidersRepository().getSliders();
    carouselResponse.sliders!.forEach((slider) {
      _carouselImageList.add(slider);
    });
    _isCarouselInitial = false;
    setState(() {});
  }

  onRefresh() async {
    access_token.load().whenComplete(() {
      AuthHelper().fetch_and_set();
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: const HomeDawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        toolbarHeight: 70,
        title: Center(
            child: Text(
          account_balance.$.isNotEmpty
              ? 'ብር ${formatter.format(int.parse(account_balance.$))}'
              : '',
          style: const TextStyle(
            color: Colors.white,
            // fontSize: 30,
            fontWeight: FontWeight.w100,
          ),
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QrPage(
                            AppLocalizations.of(context)!.my_code,
                          ))),
              child: const Icon(
                Icons.qr_code_2,
                size: 50,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => onRefresh(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    // CardWidget(screenHeight: screenHeight),
                    NewCard(user_name.$, screenHeight),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 70, right: 70, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ServiceWidget(
                              Icons.card_giftcard,
                              AppLocalizations.of(context)!.topup,
                              TopUp(
                                AppLocalizations.of(context)!.topup,
                              ),
                              fontWeight: FontWeight.w100),
                          ServiceWidget(
                              Icons.send,
                              AppLocalizations.of(context)!.send,
                              SendMoney(
                                AppLocalizations.of(context)!.send,
                              ),
                              fontWeight: FontWeight.w100),
                          ServiceWidget(
                              Icons.web,
                              AppLocalizations.of(context)!.withdraw,
                              Withdraw(
                                AppLocalizations.of(context)!.withdraw,
                              ),
                              fontWeight: FontWeight.w100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/services_background.png')),
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color(0xFFF7F7F7),
                        Color(0xFFF5F5F5),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 0),
                            child: Text(
                              AppLocalizations.of(context)!.services,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.red),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: Text(
                              '-',
                              style: TextStyle(fontSize: 50, color: Colors.red),
                            ),
                          )
                        ],
                      ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ServiceWidget(
                              Icons.airplanemode_active,
                              AppLocalizations.of(context)!.flights,
                              Airlines(AppLocalizations.of(context)!
                                  .choose_airline)),
                          ServiceWidget(
                            Icons.money,
                            AppLocalizations.of(context)!.murabaha,
                            CategoryProducts(
                              category_id: 2,
                              category_name: 'MURABAHA',
                            ),
                          ),
                          ServiceWidget(
                            Icons.local_taxi,
                            AppLocalizations.of(context)!.taxi,
                            PayOptions(AppLocalizations.of(context)!.pay_taxi),
                          ),
                          ServiceWidget(
                            Icons.request_page,
                            AppLocalizations.of(context)!.loans,
                            ComingSoon(AppLocalizations.of(context)!.loans),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ServiceWidget(
                              Icons.payment,
                              AppLocalizations.of(context)!.airtime,
                              Telecoms(AppLocalizations.of(context)!.airtime)),
                          ServiceWidget(
                            Icons.apps,
                            AppLocalizations.of(context)!.bills,
                            Bills(AppLocalizations.of(context)!.bills),
                          ),
                          ServiceWidget(
                              Icons.qr_code,
                              AppLocalizations.of(context)!.merchant,
                              PayMerchant(
                                AppLocalizations.of(context)!.merchant,
                              )),
                          ServiceWidget(
                            Icons.atm,
                            AppLocalizations.of(context)!.atm,
                            ComingSoon(AppLocalizations.of(context)!.atm),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              buildHomeCarouselSlider(context),
              SizedBox(
                height: screenHeight / 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHomeCarouselSlider(context) {
    if (_isCarouselInitial && _carouselImageList.length == 0) {
      return Padding(
          padding: const EdgeInsets.all(8),
          child: ShimmerHelper().buildBasicShimmer(height: 120));
    } else if (_carouselImageList.length > 0) {
      return CarouselSlider(
        options: CarouselOptions(
            aspectRatio: 338 / 140,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 1000),
            autoPlayCurve: Curves.easeInExpo,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _current_slider = index;
              });
            }),
        items: _carouselImageList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: Stack(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                if (i.link != null) {
                                  print(i.link);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    // return DepositPage('Deposit Money');
                                    return WebPage(i.link);
                                  }));
                                }
                              },
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/placeholder_rectangle.png',
                                image: i.photo,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            ))),
                  ],
                ),
              );
            },
          );
        }).toList(),
      );
    } else if (!_isCarouselInitial && _carouselImageList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            'Image not found',
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }
}

class ServiceWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Widget page;
  final Color? color;
  final FontWeight? fontWeight;
  const ServiceWidget(
    this.icon,
    this.text,
    this.page, {
    this.color,
    this.fontWeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => page)),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(50),
              color: Colors.red,
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Icon(
                icon,
                // color: AppColors.greyColor2,
                color: Colors.white,
                size: 20,
              ),
            ),
            // color: MyTheme.accent_color,
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.red.withOpacity(0.8),
                  fontWeight: fontWeight,
                ),
              )),
        ],
      ),
    );
  }
}

class PivotCard extends StatelessWidget {
  const PivotCard(this.clientName, this.screenHeight, {Key? key})
      : super(key: key);
  final String clientName;
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        gradient: const LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color(0xFFFAFAFA),
            Color(0xFFE3C0C0),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: screenHeight / 5.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ACCOUNT NUMBER',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                user_phone.$,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            'ACCOUNT HOLDER',
            style: TextStyle(
                color: Colors.black, fontSize: 10, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                clientName.toUpperCase(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Image(
                image: AssetImage(
                  'assets/logo.png',
                ),
                height: 30,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class NewCard extends StatelessWidget {
  const NewCard(this.clientName, this.screenHeight, {Key? key})
      : super(key: key);
  final String clientName;
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Stack(
        children: [
          Image.asset('assets/card.png'),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.account_number,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      user_phone.$,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  AppLocalizations.of(context)!.account_holder,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      clientName.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeDawer extends StatelessWidget {
  const HomeDawer({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: MyTheme.accent_color,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user_name.$,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            user_phone.$,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(fontWeight: FontWeight.w400)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        logout(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.main_drawer_logout,
                        style: TextStyle(color: MyTheme.accent_color),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.lock,
              color: MyTheme.accent_color,
            ),
            style: ListTileStyle.drawer,
            title: Text(
              AppLocalizations.of(context)!.change_pin,
              style: TextStyle(
                  color: AppColors.greyColor2, fontWeight: FontWeight.w300),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordPage(
                          AppLocalizations.of(context)!.change_pin)));
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.list,
              color: MyTheme.accent_color,
            ),
            style: ListTileStyle.drawer,
            title: Text(
              AppLocalizations.of(context)!.transaction_history,
              style: TextStyle(
                  color: AppColors.greyColor2, fontWeight: FontWeight.w300),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TransactionsPage(
                          AppLocalizations.of(context)!.transaction_summary)));
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.contact_mail,
              color: MyTheme.accent_color,
            ),
            style: ListTileStyle.drawer,
            title: Text(
              AppLocalizations.of(context)!.contact_us,
              style: TextStyle(
                  color: AppColors.greyColor2, fontWeight: FontWeight.w300),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ContactUs(AppLocalizations.of(context)!.contact_us)));
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.share,
              color: MyTheme.accent_color,
            ),
            style: ListTileStyle.drawer,
            title: Text(
              AppLocalizations.of(context)!.share_app,
              style: TextStyle(
                  color: AppColors.greyColor2, fontWeight: FontWeight.w300),
            ),
            onTap: () async {
              String appUrl = 'https://www.google.com/';
              Share.share(
                  'Hey There! I am using the HCASH App. Please download it via $appUrl');

              // String text =
              //     "Hey There! I am using the HCASH App. Please download it via $appUrl";
              // String url = "https://wa.me/?text=${Uri.encodeFull(text)}";
              // if (await canLaunchUrl(Uri.parse(url))) {
              //   await launchUrl(Uri.parse(url),
              //       mode: LaunchMode.externalApplication);
              // } else {
              //   showToast(context, 'You do not have whatsapp installed');
              // }
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.fingerprint,
              color: MyTheme.accent_color,
            ),
            style: ListTileStyle.drawer,
            title: Text(
              AppLocalizations.of(context)!.preferences,
              style: TextStyle(
                  color: AppColors.greyColor2, fontWeight: FontWeight.w300),
            ),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyPreferences(
                          AppLocalizations.of(context)!.preferences)));
            },
          ),
          const Divider(),
        ],
      ),
    );
  }

  void logout(BuildContext context) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var biometricEnabled = preferences.getBool('biometricsEnabled') ?? false;
    if (!biometricEnabled) preferences.clear();
    // ignore: use_build_context_synchronously
    showToast(context, 'Logout successful');
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false);
  }
}
