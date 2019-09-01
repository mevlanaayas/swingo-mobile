import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/services/order.dart';

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
  List<Order> orders = [];
  List<Order> sendOrders = [];
  List<Order> carryOrders = [];

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _listSendOrders(context);
      _listCarryOrders(context);
    });
    super.initState();
  }

  void _listSendOrders(BuildContext context) async {
    OrderService.listMySendOrders(
      context,
      onSuccess: _onListSendOrderRequestSuccess(context),
    );
  }

  void _listCarryOrders(BuildContext context) async {
    OrderService.listMyCarryOrders(
      context,
      onSuccess: _onListCarryOrderRequestSuccess(context),
    );
  }

  _onListSendOrderRequestSuccess(BuildContext context) {
    return (responseData) async {
      final sendOrderJsonArray = responseData['results'];
      setState(() {
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
        carryOrders = List<Order>.from(carryOrders)
          ..addAll(List<Order>.from(carryOrderJsonArray
              .map((orderJson) => Order.fromJson(orderJson))));
      });
    };
  }

  void _buildSection(List<Widget> slivers, double scale, List<Order> items) {
    if (items != null && items.isNotEmpty) {
      slivers.add(
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            Order item = items[index];
            return ListItem(item: item);
          }, childCount: items.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    orders = new List.from(sendOrders)..addAll(carryOrders);
    var slivers = <Widget>[];
    const scale = 1.0;
    _buildSection(slivers, scale, orders);
    return Container(
      padding: cardListMargin,
      constraints: const BoxConstraints(minWidth: double.infinity),
      color: primaryColor50,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: CustomScrollView(slivers: slivers)),
          ],
        ),
      ),
    );
  }
}
