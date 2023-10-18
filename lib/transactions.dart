import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:h_cash/receipt.dart';
import 'package:h_cash/responses/transaction_response.dart';
import 'package:h_cash/services/payment_services.dart';
import 'package:h_cash/sticky_grouped_list.dart';
import 'package:h_cash/sticky_grouped_list_order.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final DateFormat formatter = DateFormat('dd MMM yyyy');
  final DateFormat timeFormatter = DateFormat('hh:mm a');
  BuildContext? loadingContext;

  List<Transaction> _transactions = <Transaction>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, getTransactions);
  }

  loading() {
    showDialog(
        context: context,
        builder: (context) {
          loadingContext = context;
          return AlertDialog(
              content: Row(
            children: [
              CircularProgressIndicator(
                color: MyTheme.accent_color,
              ),
              SizedBox(
                width: 10,
              ),
              Text(AppLocalizations.of(context)!.loading_text),
            ],
          ));
        });
  }

  getTransactions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    var enddate = formatter.format(DateTime.now());
    var startDate =
        formatter.format(DateTime.now().subtract(Duration(days: 365)));

    var data = {
      "username": user_phone.$,
      "startDate": startDate,
      "endDate": enddate
    };
    loading();

    var transactionResponse = await PaymentService().getTransactions(
      jsonEncode(data),
    );
    // ignore: use_build_context_synchronously
    Navigator.of(loadingContext!).pop();
    // ignore: use_build_context_synchronously
    showToast(context, transactionResponse.message);
    setState(() {
      _transactions = transactionResponse.transactions;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(screenWidth, 60),
          child: CustomAppBar(widget.title, Icons.calendar_month)),
      body: SafeArea(
        child: StickyGroupedListView<Transaction, DateTime>(
          elements: _transactions,
          order: StickyGroupedListOrder.ASC,
          groupBy: (Transaction transaction) => DateTime(
            transaction.date.year,
            transaction.date.month,
            transaction.date.day,
          ),
          groupComparator: (DateTime value1, DateTime value2) =>
              value2.compareTo(value1),
          itemComparator:
              (Transaction transaction1, Transaction transaction2) =>
                  transaction1.date.compareTo(transaction2.date),
          floatingHeader: true,
          groupSeparatorBuilder: _getGroupSeparator,
          itemBuilder: _getItem,
        ),
      ),
    );
  }

  Widget _getGroupSeparator(Transaction transaction) {
    return SizedBox(
      height: 50,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: MyTheme.accent_color,
            border: Border.all(
              color: MyTheme.accent_color,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              formatter.format(transaction.date),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getItem(BuildContext ctx, Transaction transaction) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Receipt(
                AppLocalizations.of(context)!.receipt,
                transaction.serviceName,
                transaction.fromAccount,
                transaction.toAccount,
                transaction.amount,
                transaction.sender,
                transaction.recipient,
                transaction.transactionCharge,
                transaction.transactionStatus,
                transaction.date.toString(),
                transaction.transactionReference);
          }));
        },
        child: SizedBox(
          child: ListTile(
            isThreeLine: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Icon(Icons.send, color: MyTheme.accent_color),
            title: Text(
              transaction.serviceName,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
            subtitle: Text(
              "ETB ${transaction.amount} \n${transaction.recipient} ",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 12,
              ),
            ),
            trailing: Text(
              timeFormatter.format(transaction.date),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}
