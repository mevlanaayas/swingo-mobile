import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/services/match.dart';

class Matches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MatchesScreen(),
    );
  }
}

class MatchesScreen extends StatefulWidget {
  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  List<SwMatch> matches;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _listMatches(context);
    });
    super.initState();
  }

  void _listMatches(BuildContext context) async {
    MatchService.listAll(
      context,
      onSuccess: _onRequestSuccess(context),
    );
  }

  _onRequestSuccess(BuildContext context) {
    return (responseData) async {
      final orderJsonArray = responseData['matches'];
      print(orderJsonArray);
      setState(() {
        matches = List<SwMatch>.from(
            orderJsonArray.map((orderJson) => SwMatch.fromJson(orderJson)));
      });
    };
  }

  void _buildSection(List<Widget> slivers, double scale, List<SwMatch> items) {
    if (items != null && items.isNotEmpty) {
      slivers.add(SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          SwMatch item = items[index];
          return MatchItem(item: item);
        }, childCount: items.length),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var slivers = <Widget>[];
    const scale = 1.0;
    _buildSection(slivers, scale, matches);
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
