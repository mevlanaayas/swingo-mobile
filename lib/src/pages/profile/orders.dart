import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/services/order.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrdersScreen(),
    );
  }
}

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> orders;


  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _listOrders(context);
    });
    super.initState();
  }

  void _listOrders(BuildContext context) async {
    OrderService.listAll(
      context,
      onSuccess: _onRequestSuccess(context),
    );
  }

  _onRequestSuccess(BuildContext context) {
    return (responseData) async {
      final carryOrderJsonArray = responseData['carry_orders'];
      final sendOrderJsonArray = responseData['send_orders'];
      setState(() {
        orders = List<Order>.from(
        carryOrderJsonArray.map((orderJson) => Order.fromJson(orderJson)))
        ..addAll(List<Order>.from(sendOrderJsonArray
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
    var slivers = <Widget>[];
    const scale = 1.0;
    _buildSection(slivers, scale, orders);
    return Container(
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
