import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/input_decorations.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Receipt extends StatefulWidget {
  const Receipt(
    this.title,
    this.serviceName,
    this.fromAccount,
    this.toAccount,
    this.transactionAmount,
    this.sender,
    this.recipient,
    this.transactionCharge,
    this.transactionStatus,
    this.transactionDate,
    this.transactionReference, {
    Key? key,
  }) : super(key: key);

  final String title,
      serviceName,
      fromAccount,
      toAccount,
      transactionAmount,
      sender,
      recipient,
      transactionCharge,
      transactionStatus,
      transactionDate,
      transactionReference;

  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(screenWidth, 60),
            child: CustomAppBar(widget.title, Icons.person)),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: buildBody(),
        ));
  }

  Widget creditForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        ReceiptItem(
          label: AppLocalizations.of(context)!.transaction_type,
          value: widget.serviceName,
        ),
        SizedBox(
          height: 30,
        ),
        ReceiptItem(
          label: AppLocalizations.of(context)!.sender_account,
          value: widget.fromAccount,
        ),
        SizedBox(
          height: 30,
        ),
        ReceiptItem(
          label: AppLocalizations.of(context)!.sender_name,
          value: widget.sender,
        ),
        SizedBox(
          height: 30,
        ),
        ReceiptItem(
          label: AppLocalizations.of(context)!.recipient_account,
          value: widget.toAccount,
        ),
        SizedBox(
          height: 30,
        ),
        ReceiptItem(
          label: AppLocalizations.of(context)!.recipient_name,
          value: widget.recipient,
        ),
        SizedBox(
          height: 30,
        ),
        ReceiptItem(
          label: AppLocalizations.of(context)!.transaction_amount,
          value: widget.transactionAmount,
        ),
        SizedBox(
          height: 30,
        ),
        ReceiptItem(
          label: AppLocalizations.of(context)!.transaction_charge,
          value: widget.transactionCharge,
        ),
        SizedBox(
          height: 30,
        ),
        ReceiptItem(
          label: AppLocalizations.of(context)!.transaction_date,
          value: widget.transactionDate,
        ),
        SizedBox(
          height: 30,
        ),
        ReceiptItem(
          label: AppLocalizations.of(context)!.transaction_reference,
          value: widget.transactionReference,
        ),
        SizedBox(
          height: 30,
        ),
        ReceiptItem(
          label: AppLocalizations.of(context)!.transaction_status,
          value: widget.transactionStatus,
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            buildDescription(widget.title,
                description:
                    AppLocalizations.of(context)!.transaction_description),
            creditForm(),
          ],
        ),
      ),
    );
  }
}

class ReceiptItem extends StatelessWidget {
  const ReceiptItem({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.dashboardColor,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
