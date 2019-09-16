import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/services/order.dart';
import 'package:swingo/src/utils/constans.dart';

class ListScreen extends StatefulWidget with SwScreen {
  final String type;

  ListScreen(this.type);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Order> carriers = [];
  List<Order> senders = [];
  String nextPage = null;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      widget.type == ORDER_OWNER_TYPES["SENDER"]
          ? _listSenders(context)
          : _listCarriers(context);
    });
    super.initState();
  }

  void _buildSection(List<Widget> slivers, double scale, List<Order> items) {
    if (items != null && items.isNotEmpty) {
      slivers.add(
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            Order item = items[index];
            return ListItem(
              item: item,
              orderOwnerType: widget.type,
            );
          }, childCount: items.length),
        ),
      );
    }
  }

  void _listSenders(BuildContext context, {String url}) async {
    OrderService.listSenders(
      context,
      url: url,
      onSuccess: _onRequestSuccess(context),
    );
  }

  void _listCarriers(BuildContext context, {String url}) async {
    OrderService.listCarriers(
      context,
      url: url,
      onSuccess: _onRequestSuccess(context),
    );
  }

  _onRequestSuccess(BuildContext context) {
    return (responseData) async {
      final orderJsonArray = responseData['results'];
      if (widget.type == ORDER_OWNER_TYPES["SENDER"]) {
        setState(() {
          nextPage = responseData['links']['next'];
          senders = List<Order>.from(senders)
            ..addAll(List<Order>.from(
                orderJsonArray.map((orderJson) => Order.fromJson(orderJson))));
        });
      } else {
        setState(() {
          nextPage = responseData['links']['next'];
          carriers = List<Order>.from(carriers)
            ..addAll(List<Order>.from(
                orderJsonArray.map((orderJson) => Order.fromJson(orderJson))));
        });
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    var slivers = <Widget>[];
    const scale = 1.0;
    widget.type == ORDER_OWNER_TYPES["SENDER"]
        ? _buildSection(slivers, scale, this.senders)
        : _buildSection(slivers, scale, this.carriers);
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      color: pageBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: cardListMargin,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent &&
                        nextPage != null) {
                      String url = nextPage;
                      setState(() {
                        nextPage = null;
                      });
                      widget.type == ORDER_OWNER_TYPES["SENDER"]
                          ? _listSenders(context, url: url)
                          : _listCarriers(context, url: url);
                    }
                  },
                  child: CustomScrollView(slivers: slivers),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
