import 'package:flutter/material.dart';
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/my_theme.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData icon;
  const CustomAppBar(this.title, this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: AppColors.appBarColor,
      backgroundColor: MyTheme.accent_color,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Icon(icon),
        ),
      ],
    );
  }
}

class CustomHeader extends StatelessWidget {
  final String heading;
  final String subHeading;
  const CustomHeader(this.heading, this.subHeading, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            heading,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Text(subHeading, style: const TextStyle(color: Colors.grey)),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

class MediumText extends StatelessWidget {
  const MediumText(
    this.text, {
    this.color = Colors.black,
    Key? key,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontWeight: FontWeight.w300, fontSize: 13),
    );
  }
}
