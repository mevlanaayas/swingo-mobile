import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  List<Order> carriers;
  List<Order> senders;
  int currentPage = 1;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      widget.type == ORDER_OWNER_TYPES["SENDER"]
          ? _listSenders(context, currentPage)
          : _listCarriers(context, currentPage);
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

  void _listSenders(BuildContext context, int page) async {
    OrderService.listSenders(
      context,
      page: page,
      onSuccess: _onRequestSuccess(context),
    );
  }

  void _listCarriers(BuildContext context, int page) async {
    OrderService.listCarriers(
      context,
      page: page,
      onSuccess: _onRequestSuccess(context),
    );
  }

  _onRequestSuccess(BuildContext context) {
    return (responseData) async {
      final orderJsonArray = responseData['results'];
      if (widget.type == ORDER_OWNER_TYPES["SENDER"]) {
        setState(() {
          senders = List<Order>.from(
              orderJsonArray.map((orderJson) => Order.fromJson(orderJson)));
        });
      } else {
        setState(() {
          carriers = List<Order>.from(
              orderJsonArray.map((orderJson) => Order.fromJson(orderJson)));
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
      color: primaryColor50,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /*Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: ButtonTheme(
                    minWidth: 0,
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      padding: const EdgeInsets.all(0),
                      shape: null,
                      onPressed: () => Navigator.pop(context, null),
                      child: const Icon(
                        FontAwesomeIcons.chevronLeft,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.type.toUpperCase(),
                  style: itemDetailHeadingStyle,
                )
              ],
            ),*/
            Expanded(child: CustomScrollView(slivers: slivers)),
          ],
        ),
      ),
    );
  }
}
