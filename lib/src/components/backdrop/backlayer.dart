import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';
import 'package:swingo/src/models/product.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/theme/colors.dart';
import 'package:swingo/src/utils/constans.dart';

import 'frontlayer.dart';

class Backdrop extends StatefulWidget {
  final Category currentCategory;
  Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;
  final Widget subheader;

  Backdrop(
      {@required this.currentCategory,
      @required this.frontLayer,
      @required this.backLayer,
      @required this.frontTitle,
      @required this.backTitle,
      this.subheader})
      : assert(currentCategory != null),
        assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null),
        assert(backTitle != null);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop> with TickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  AnimationController _controller;
  int general = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(Backdrop old) {
    super.didUpdateWidget(old);

    if (widget.currentCategory != old.currentCategory) {
      _toggleBackdropLayerVisibility();
    } else if (!_frontLayerVisible) {
      _controller.fling(velocity: swFlingVelocity);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
        velocity: _frontLayerVisible ? -swFlingVelocity : swFlingVelocity);
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible,
        ),
        PositionedTransition(
          rect: layerAnimation,
          child: FrontLayer(
            onTap: _toggleBackdropLayerVisibility,
            child: widget.frontLayer,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController =
        TabController(initialIndex: general, length: 3, vsync: this);

    void _handleTabSelection() {
      if (_tabController.indexIsChanging) {
        print("tab");
        print(_tabController.index);
        setState(() {
          general = _tabController.index;
          if (_tabController.index == 0) {
            widget.frontLayer = HomePage();
          } else if (_tabController.index == 1) {
            widget.frontLayer = LoginPage();
          } else {
            widget.frontLayer = RegisterPage();
          }
        });
      }
    }

    _tabController.addListener(_handleTabSelection);

    @override
    void dispose() {
      _tabController.dispose();
      super.dispose();
    }

    var appBar = AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        titleSpacing: 0.0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: _toggleBackdropLayerVisibility,
        ),
        title: Text('Swingo'),
        bottom: TabBar(
          unselectedLabelColor: Colors.deepPurple.withOpacity(0.6),
          indicator: BoxDecoration(
              border: Border.all(color: altDeepPurple, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(40.0))),
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
            Tab(icon: Icon(Icons.directions_bike)),
          ],
        ));
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: appBar,
          body: LayoutBuilder(builder: _buildStack),
        ));
  }
}
