import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:badges/badges.dart' as bg;
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/front_page.dart';
import 'package:h_cash/login_page.dart';
import 'package:h_cash/marketplace/bottom_appbar_index.dart';
import 'package:h_cash/marketplace/cart.dart';
import 'package:h_cash/marketplace/cart_counter.dart';
import 'package:h_cash/marketplace/cart_repository.dart';
import 'package:h_cash/marketplace/category_list.dart';
import 'package:h_cash/marketplace/common_functions.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/profile_page.dart';
import 'package:route_transitions/route_transitions.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key, go_back = true}) : super(key: key);

  bool? go_back;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  //int _cartCount = 0;

  BottomAppbarIndex bottomAppbarIndex = BottomAppbarIndex();

  CartCounter counter = CartCounter();

  var _children = [];

  fetchAll() {
    getCartCount();
  }

  void onTapped(int i) {
    fetchAll();
    if (!is_logged_in.$ && (i == 3 || i == 2)) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
      return;
    }

    if (i == 3) {
      app_language_rtl.$
          ? slideLeftWidget(newPage: ProfilePage(), context: context)
          : slideRightWidget(newPage: ProfilePage(), context: context);
      return;
    }

    setState(() {
      _currentIndex = i;
    });
    //print("i$i");
  }

  getCartCount() async {
    var res = await CartRepository().getCartCount();

    counter.controller!.sink.add(res.count!);
  }

  void initState() {
    _children = [
      FrontPage(
        'Home',
        counter,
      ),
      CategoryList(
        is_base_category: true,
      ),
      Cart(
        has_bottomnav: true,
        from_navigation: true,
        counter: counter,
      ),
      ProfilePage(),
    ];
    fetchAll();
    // TODO: implement initState
    //re appear statusbar in case it was not there in the previous page
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //print("_currentIndex");
        if (_currentIndex != 0) {
          fetchAll();
          setState(() {
            _currentIndex = 0;
          });
          return false;
        } else {
          CommonFunctions(context).appExitDialog();
        }
        return widget.go_back!;
      },
      child: Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          extendBody: true,
          body: _children[_currentIndex],
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: SizedBox(
                height: 83,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: onTapped,
                  currentIndex: _currentIndex,
                  // backgroundColor: AppColors.appBarColor,
                  // backgroundColor: Colors.red,
                  unselectedItemColor: AppColors.greyColor2,
                  selectedItemColor: Colors.red,
                  selectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(168, 175, 179, 1),
                  ),
                  items: [
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Image.asset(
                          "assets/home.png",
                          color: _currentIndex == 0
                              ? Colors.red
                              : AppColors.greyColor2,
                          height: 16,
                        ),
                      ),
                      label: AppLocalizations.of(context)!
                          .main_screen_bottom_navigation_home,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Image.asset(
                          "assets/categories.png",
                          color: _currentIndex == 1
                              ? Colors.red
                              : AppColors.greyColor2,
                          height: 16,
                        ),
                      ),
                      label: AppLocalizations.of(context)!.marketplace,
                    ),
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: bg.Badge(
                            child: Image.asset(
                              "assets/cart.png",
                              color: _currentIndex == 2
                                  ? Colors.red
                                  : AppColors.greyColor2,
                              height: 16,
                            ),
                            badgeContent: StreamBuilder<int>(
                                stream: counter.controller!.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData)
                                    return Text(snapshot.data.toString() + "",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 8));
                                  return Text("0",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 8));
                                }),
                          ),
                        ),
                        label: AppLocalizations.of(context)!
                            .main_screen_bottom_navigation_cart),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Image.asset(
                          "assets/profile.png",
                          color: _currentIndex == 3
                              ? Colors.red
                              : AppColors.greyColor2,
                          height: 20,
                        ),
                      ),
                      label: AppLocalizations.of(context)!
                          .main_screen_bottom_navigation_profile,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
