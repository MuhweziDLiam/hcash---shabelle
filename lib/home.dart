import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:h_cash/airlines.dart';
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/auth_helper.dart';
import 'package:h_cash/bills.dart';
import 'package:h_cash/change_password.dart';
import 'package:h_cash/coming_soon.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/deposit.dart';
import 'package:h_cash/login_page.dart';
import 'package:h_cash/marketplace/cart_counter.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/marketplace/shimmer_helper.dart';
import 'package:h_cash/marketplace/sliders_repository.dart';
import 'package:h_cash/marketplace/web_page.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/pay_bill.dart';
import 'package:h_cash/qr_page.dart';
import 'package:h_cash/qr_pay.dart';
import 'package:h_cash/send_money.dart';
import 'package:h_cash/services/auth_services.dart';
import 'package:h_cash/transactions.dart';
import 'package:h_cash/withdraw.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePage extends StatefulWidget {
  const HomePage(this.title, this.counter, {Key? key}) : super(key: key);

  final String title;
  final CartCounter counter;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: AppColors.appBarColor,
      drawer: HomeDawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appBarColor,
        toolbarHeight: 70,
        title: const Center(
          child: Text(
            'HOME',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QrPage('My Code'))),
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
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.appBarColor,
                      AppColors.dashboardColor,
                    ],
                  ),
                ),
                height: screenHeight / 2.5,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Directionality(
                          //   textDirection: TextDirection.rtl,
                          //   child: ElevatedButton.icon(
                          //     onPressed: () {
                          //       setState(() {
                          //         isMasked = !isMasked;
                          //       });
                          //     },
                          //     style: ButtonStyle(
                          //         backgroundColor:
                          //             MaterialStateProperty.all(Colors.white)),
                          //     icon: !isMasked
                          //         ? Icon(
                          //             Icons.visibility,
                          //             color: AppColors.dashboardColor,
                          //           )
                          //         : Icon(
                          //             Icons.visibility_off,
                          //             color: AppColors.dashboardColor,
                          //           ),
                          //     label: Text(
                          //       !isMasked
                          //           ? 'ETB ${clientBalance!.toUpperCase()}'
                          //           : 'ETB XXXXX',
                          //       style: TextStyle(
                          //         color: AppColors.dashboardColor,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Text(
                            account_balance.$.isNotEmpty
                                ? 'ብር ${formatter.format(int.parse(account_balance.$))}'
                                : '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // CardWidget(screenHeight: screenHeight),
                    PivotCard(user_name.$),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ServiceWidget(
                              Icons.send, 'Send', SendMoney('Send Money')),
                          ServiceWidget(Icons.card_giftcard, 'Deposit',
                              DepositPage('Deposit', false)),
                          ServiceWidget(
                              Icons.web, 'Withdraw', Withdraw('Withdraw')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SERVICES',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    // GestureDetector(
                    //   onTap: () => Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => Bills('Services'))),
                    //   child: Text(
                    //     'View All',
                    //     style: TextStyle(
                    //         // fontWeight: FontWeight.bold,
                    //         fontSize: 15,
                    //         color: AppColors.dashboardColor),
                    //   ),
                    // ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HomeService(Icons.money, 'SAVINGS & LOANS',
                        ComingSoon('SAVINGS & LOANS')),
                    HomeService(Icons.local_taxi, 'PAY TAXI',
                        PayBill('Pay Taxi', 'TAXI')),
                    HomeService(Icons.airplanemode_active, 'AIR TICKET',
                        Airlines('Choose Airline')),
                  ],
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HomeService(Icons.atm_rounded, 'Cardless ATM',
                        ComingSoon('Cardless ATM')),
                    HomeService(Icons.qr_code, 'QR Pay', QrPay('QR Pay')),
                    ServiceWidget(
                      Icons.apps,
                      'Bills',
                      Bills('Bills'),
                      color: AppColors.dashboardColor,
                    ),
                  ],
                ),
              ),

              buildHomeCarouselSlider(context),
              SizedBox(
                height: screenHeight / 12,
              ),

              // RecentActivities(
              //     screenHeight: screenHeight, screenWidth: screenWidth),
              // OtherServices(screenHeight: screenHeight),
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

class RecentActivities extends StatelessWidget {
  const RecentActivities({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 3,
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: [
      //       Colors.white,
      //       Color(0xFFE1E1E1),
      //       Colors.blue.shade50,
      //     ],
      //   ),
      // ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              children: const [
                Text(
                  'RECENT ACTIVITIES',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TopUp(
                  screenHeight: screenHeight * 0.25,
                  screenWidth: screenWidth * 0.44,
                ),
                Column(
                  children: [
                    RecentTransaction(
                      screenHeight: screenHeight * 0.12,
                      screenWidth: screenWidth * 0.44,
                      amount: 'ETB 11,230',
                      name: 'Edward Kamya',
                      date: '30 May 2023',
                      type: 'Received',
                      image: 'assets/man.jpg',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RecentTransaction(
                      screenHeight: screenHeight * 0.12,
                      screenWidth: screenWidth * 0.44,
                      amount: 'ETB 11,230',
                      name: 'Denis Muhwezi',
                      date: '28 May 2023',
                      type: 'Sent',
                      image: 'assets/edward.png',
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

class RecentTransaction extends StatelessWidget {
  const RecentTransaction({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.type,
    required this.amount,
    required this.name,
    required this.date,
    required this.image,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final String type;
  final String amount;
  final String name;
  final String date;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFede0bd)),
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0, top: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      type,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: MyTheme.font_grey),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      amount,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 12, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image(
                              image: AssetImage(image),
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                // color: AppColors.dashboardColor,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            date,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: MyTheme.font_grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TopUp extends StatelessWidget {
  const TopUp({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xFFede0bd)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFFC40E), Color(0xFFFAA71B)],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  Icons.money,
                  color: AppColors.dashboardColor,
                ),
              ),
              // color: MyTheme.accent_color,
            ),
          ),
          Text(
            'Top Up',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: MyTheme.font_grey),
          ),
          const Text(
            'ETB 1,000',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          Text(
            '30 May 2023',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: MyTheme.font_grey),
          ),
          SizedBox(
            height: 30,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: MediaQuery.of(context).size,
                  disabledBackgroundColor: MyTheme.grey_153,
                  //height: 50,
                  backgroundColor: AppColors.dashboardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Details',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TransactionsPage('Transactions')));
                }),
          ),
        ],
      ),
    );
  }
}

class ServiceWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Widget page;
  final Color? color;
  const ServiceWidget(
    this.icon,
    this.text,
    this.page, {
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => page)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFFC40E), Color(0xFFFAA71B)],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Icon(
                  icon,
                  color: AppColors.dashboardColor,
                  size: 20,
                ),
              ),
              // color: MyTheme.accent_color,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: MediumText(
                text,
                color: color ?? Colors.white,
              )),
        ],
      ),
    );
  }
}

class HomeService extends StatelessWidget {
  final String text;
  final IconData icon;
  final Widget page;
  const HomeService(
    this.icon,
    this.text,
    this.page, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => page)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.dashboardColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              // color: MyTheme.accent_color,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: MediumText(
                text,
                color: AppColors.dashboardColor,
              )),
        ],
      ),
    );
  }
}

class PivotCard extends StatelessWidget {
  const PivotCard(this.clientName, {Key? key}) : super(key: key);
  final String clientName;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          // colors: [Color(0xFFFFC40E), Color(0xFFFAA71B)],
          colors: [Colors.blue, Colors.green],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Image(
                      image: AssetImage('assets/logo_icon.png'),
                      height: 15,
                    ),
                  ),
                  MediumText(
                    'CASH',
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              MediumText(
                'XXXX XXXX XXXX XXXX',
                color: Colors.white,
              ),
              Image(
                image: AssetImage(
                  'assets/chip.png',
                ),
                height: 30,
              ),
            ],
          ),
          Row(
            children: const [
              MediumText(
                'EXPIRY DATE',
                color: Colors.white,
              ),
              SizedBox(width: 20),
              MediumText(
                '12/25',
                color: Colors.white,
              ),
              SizedBox(width: 100),
            ],
          ),
          const SizedBox(height: 20),
          MediumText(
            'CARD HOLDER',
            color: Colors.white,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MediumText(
                clientName.toUpperCase(),
                color: Colors.white,
              ),
              Image(
                image: AssetImage(
                  'assets/mastercard.png',
                ),
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFC40E), Color(0xFFFAA71B)],
            ),
          ),
          height: screenHeight / 4,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Allan Abaho',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: MediaQuery.of(context).size,
                            disabledBackgroundColor: MyTheme.grey_153,
                            //height: 50,
                            backgroundColor: AppColors.dashboardColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            'ADD CREDIT',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DepositPage('Deposit', false)),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  children: const [
                    Text(
                      '3684 XXXX XXXX 9816',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Image(
                        image: AssetImage('assets/logo_icon.png'),
                        height: 40,
                      ),
                    ),
                    Text(
                      'CASH',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 4),
                child: Row(
                  children: [
                    GradientText(
                      'Total Balance',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      colors: [
                        Color(0xFF004C70),
                        Color(0xFF1A6B9D),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GradientText(
                      'ETB 270,365',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                      colors: [
                        Color(0xFF004C70),
                        Color(0xFF1A6B9D),
                      ],
                    ),
                    Row(
                      children: [
                        Image(
                          image: AssetImage('assets/mastercard.png'),
                          height: 25,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                          child: const Image(
                            image: AssetImage('assets/profile.jpg'),
                            height: 70,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Allan Abaho',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'abahoallans@gmail.com',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(fontWeight: FontWeight.w400)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      onPressed: () async {
                        final SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.clear();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => false);
                      },
                      child: const Text('Logout'),
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
              'Change PIN',
              style: TextStyle(
                  color: AppColors.dashboardColor, fontWeight: FontWeight.w400),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ChangePasswordPage('Change PIN')));
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.notifications,
              color: MyTheme.accent_color,
            ),
            style: ListTileStyle.drawer,
            title: Text(
              'Notifications',
              style: TextStyle(
                  color: AppColors.dashboardColor, fontWeight: FontWeight.w400),
            ),
            // onTap: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const ChangePasswordPage()));
            // },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.contact_mail,
              color: MyTheme.accent_color,
            ),
            style: ListTileStyle.drawer,
            title: Text(
              'Contact Us',
              style: TextStyle(
                  color: AppColors.dashboardColor, fontWeight: FontWeight.w400),
            ),
            // onTap: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const ChangePasswordPage()));
            // },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.people,
              color: MyTheme.accent_color,
            ),
            style: ListTileStyle.drawer,
            title: Text(
              'Beneficiaries',
              style: TextStyle(
                  color: AppColors.dashboardColor, fontWeight: FontWeight.w400),
            ),
            // onTap: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const ChangePasswordPage()));
            // },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
