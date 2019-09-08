import 'package:flutter/material.dart';
import 'package:swingo/src/components/sw_custom_tab_indicator.dart';
import 'package:swingo/src/models/filter.dart';
import 'package:swingo/src/pages/home/carrier_orders.dart';
import 'package:swingo/src/pages/home/sender_orders.dart';
import 'package:swingo/src/theme/style.dart';

class HomeScreen extends StatefulWidget {
  final Filter filter;

  HomeScreen({this.filter});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        elevation: 0,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.all(0),
          title: SafeArea(
            child: Container(
              color: appBarColor,
              alignment: Alignment.center,
              child: TabBar(
                //indicator: CustomTabIndicator(),
                labelColor: tabBarTextColor,
                unselectedLabelColor: tabBarUnselectedTextColor,
                indicatorColor: appBarTextColor,
                indicatorPadding: EdgeInsets.symmetric(vertical: 0),
                controller: _tabController,
                tabs: [
                  Tab(
                    child: Text(
                      'Senders',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Carriers',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          centerTitle: true,
          collapseMode: CollapseMode.parallax,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return TabBarView(controller: _tabController, children: [
      SenderOrdersScreen(),
      CarrierOrdersScreen()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}
