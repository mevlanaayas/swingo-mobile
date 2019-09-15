import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/services/match.dart';

class MatchesScreen extends StatelessWidget with SwScreen {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.buildAppbar(
        context,
        hideBackButton: true,
        title: 'Matches',
      ),
      body: Matches(),
    );
  }
}

class Matches extends StatefulWidget {
  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  List<SwMatch> matches = [];
  var slivers = <Widget>[];
  String nextPage;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _listMatches(context);
    });
    nextPage = null;
    super.initState();
  }

  void _listMatches(BuildContext context, {String url}) async {
    MatchService.listAll(
      context,
      onSuccess: _onRequestSuccess(context),
      url: url,
    );
  }

  _onRequestSuccess(BuildContext context) {
    return (responseData) async {
      final matchJsonArray = responseData['results'];
      setState(() {
        nextPage = responseData['links']['next'];
        matches = List<SwMatch>.from(matches)
          ..addAll(List<SwMatch>.from(
              matchJsonArray.map((orderJson) => SwMatch.fromJson(orderJson))));
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
    // TODO: sliver'ı sıfırlamak yerine yeni gelenleri ekle sadece
    slivers = [];
    const scale = 1.0;
    _buildSection(slivers, scale, matches);
    return Container(
      padding: cardListMargin,
      constraints: const BoxConstraints(minWidth: double.infinity),
      color: pageBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    nextPage != null) {
                  print("daha fazla yükle!!!");
                  String url = nextPage;
                  setState(() {
                    nextPage = null;
                  });
                  _listMatches(context, url: url);
                  //loadMore();
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
