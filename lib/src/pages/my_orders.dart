import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/services/order.dart';
import 'package:swingo/src/utils/constans.dart';

class MyOrdersScreen extends StatelessWidget with SwScreen {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.buildAppbar(
        context,
        hideBackButton: true,
        title: 'My Orders',
      ),
      body: MyOrders(),
    );
  }
}

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<Order> sendOrders = [];
  List<Order> carryOrders = [];
  String nextSendOrderPage = null;
  String nextCarryOrderPage = null;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _listSendOrders(context);
      _listCarryOrders(context);
    });
    super.initState();
  }

  void _listSendOrders(BuildContext context, {String url}) async {
    OrderService.listMySendOrders(
      context,
      url: url,
      onSuccess: _onListSendOrderRequestSuccess(context),
    );
  }

  void _listCarryOrders(BuildContext context, {String url}) async {
    OrderService.listMyCarryOrders(
      context,
      url: url,
      onSuccess: _onListCarryOrderRequestSuccess(context),
    );
  }

  _onListSendOrderRequestSuccess(BuildContext context) {
    return (responseData) async {
      final sendOrderJsonArray = responseData['results'];
      setState(() {
        nextSendOrderPage = responseData['links']['next'];
        sendOrders = List<Order>.from(sendOrders)
          ..addAll(List<Order>.from(sendOrderJsonArray
              .map((orderJson) => Order.fromJson(orderJson))));
      });
    };
  }

  _onListCarryOrderRequestSuccess(BuildContext context) {
    return (responseData) async {
      final carryOrderJsonArray = responseData['results'];
      setState(() {
        nextCarryOrderPage = responseData['links']['next'];
        carryOrders = List<Order>.from(carryOrders)
          ..addAll(List<Order>.from(carryOrderJsonArray
              .map((orderJson) => Order.fromJson(orderJson))));
      });
    };
  }

  void _buildSection(
    List<Widget> slivers,
    double scale, {
    List<Order> senderItems,
    List<Order> carrierItems,
  }) {
    //TODO: carrier sender da bi takım bozukluklar var. yerleri farklı gibi. bir bak hele
    if (senderItems != null && senderItems.isNotEmpty) {
      slivers.add(
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            Order item = senderItems[index];
            return ListItem(
              item: item,
              orderOwnerType: ORDER_OWNER_TYPES['CARRIER'],
            );
          }, childCount: senderItems.length),
        ),
      );
    }
    if (carrierItems != null && carrierItems.isNotEmpty) {
      slivers.add(
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            Order item = carrierItems[index];
            return ListItem(
              item: item,
              orderOwnerType: ORDER_OWNER_TYPES['SENDER'],
            );
          }, childCount: carrierItems.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var slivers = <Widget>[];
    const scale = 1.0;
    _buildSection(
      slivers,
      scale,
      senderItems: sendOrders,
      carrierItems: carryOrders,
    );
    return Container(
      padding: cardListMargin,
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
                child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  print("*****");
                  if(nextSendOrderPage != null){
                    String url = nextSendOrderPage;
                    setState(() {
                      nextSendOrderPage = null;
                    });
                    _listSendOrders(context, url: url);
                  }
                  if(nextCarryOrderPage != null){
                    String url = nextCarryOrderPage;
                    setState(() {
                      nextCarryOrderPage = null;
                    });
                    _listCarryOrders(context, url: url);
                  }
                }
              },
              child: CustomScrollView(slivers: slivers),
            )),
          ],
        ),
      ),
    );
  }
}
