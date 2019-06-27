import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/services/bid.dart';

class Bids extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BidsScreen(),
    );
  }
}

class BidsScreen extends StatefulWidget {
  @override
  _BidsScreenState createState() => _BidsScreenState();
}

class _BidsScreenState extends State<BidsScreen> {
  List<Bid> bids;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _listBids(context);
    });
    super.initState();
  }

  void _listBids(BuildContext context) async {
    BidService.listAll(
      context,
      onSuccess: _onRequestSuccess(context),
    );
  }

  _onRequestSuccess(BuildContext context) {
    return (responseData) async {
      final incomingBidJsonArray = responseData['incoming_bids'];
      final outgoingBidJsonArray = responseData['outgoing_bids'];
      setState(() {
        bids = List<Bid>.from(
            incomingBidJsonArray.map((orderJson) => Bid.fromJson(orderJson)))
          ..addAll(List<Bid>.from(outgoingBidJsonArray
              .map((orderJson) => Bid.fromJson(orderJson))));
      });
    };
  }

  void _buildSection(List<Widget> slivers, double scale, List<Bid> items) {
    if (items != null && items.isNotEmpty) {
      slivers.add(SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          Bid item = items[index];
          return BidItem(item: item);
        }, childCount: items.length),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var slivers = <Widget>[];
    const scale = 1.0;
    _buildSection(slivers, scale, bids);
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      color: primaryColor50,
      child: Padding(
        padding: EdgeInsets.only(
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
