import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';
import 'package:swingo/src/models/filter.dart';
import 'package:swingo/src/pages/frontlayer.dart';
import 'package:swingo/src/theme/colors.dart';
import 'package:swingo/src/utils/constans.dart';
import 'package:swingo/src/components/sw_button.dart';

import 'frontlayer.dart';

class Backdrop extends StatefulWidget {
  final Filter currentFilter;
  List<FrontlayerPage> frontLayer;
  final Widget backLayer;
  final Widget subheader;
  final Widget navbar;

  Backdrop(
      {@required this.currentFilter,
      @required this.frontLayer,
      @required this.backLayer,
      @required this.navbar,
      this.subheader})
      : assert(frontLayer != null),
        assert(backLayer != null),
        assert(navbar != null);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop> with TickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  final isLoggedIn = false; //todo: backendden alınması gerekiyor

  AnimationController _controller;
  AnimationController _fabAnimationController;
  int general = 0; // tab index
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
    _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(Backdrop old) {
    super.didUpdateWidget(old);
    /*
    print(_frontLayerVisible);
    if (widget.currentCategory != old.currentCategory) {
      _toggleBackdropLayerVisibility();
    } else if (!_frontLayerVisible) {
      _controller.fling(velocity: swFlingVelocity);
    }
    */
  }

  @override
  void dispose() {
    _controller.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  bool get _isCreateOptionsActive {
    final AnimationStatus status = _fabAnimationController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
        velocity: _frontLayerVisible ? -swFlingVelocity : swFlingVelocity);
  }

  void _onFloatingActionButtonPressed() {
    _fabAnimationController.fling(
        velocity: _isCreateOptionsActive ? -swFlingVelocity : swFlingVelocity
    );
  }

  void _navigateToCreateSendOrder(BuildContext context){
    if(isLoggedIn){
      Navigator.of(context).pushNamed('/create-send-order');
    } else {
      Navigator.of(context).pushNamed('/route');
    }
  }

  void _navigateToCreateCarryOrder(BuildContext context){
    if(isLoggedIn){
      Navigator.of(context).pushNamed('/create-carry-order');
    } else {
      Navigator.of(context).pushNamed('/route');
    }
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 248.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);

    Animation _fadeAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_fabAnimationController);

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
            children: widget.frontLayer,
            tabController: _tabController
          ),
        ),
        Positioned(
            bottom: 56.0 + 16.0, //todo: navbar 56 yazdığı için burada böyle kullanıyoruz.
            left: 0,
            right: 0,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(flex: 5),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SwButton(
                        onPressed: () => _navigateToCreateSendOrder(context),
                        text: 'Send'
                    )
                  ),
                  Spacer(flex: 2),
                  FadeTransition(
                      opacity: _fadeAnimation,
                      child: SwButton(
                          onPressed: () => _navigateToCreateCarryOrder(context),
                          text: 'Carry'
                      )
                  ),
                  Spacer(flex: 5),
                ],
              ),
            )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _tabController = TabController(initialIndex: general, length: 2, vsync: this);
    _tabController.index = general;

    @override
    void dispose() {
      _tabController.dispose();
      super.dispose();
    }

    var appBar = PreferredSize(
        // TODO: inanıyorsan +8.0'ı kaldır
        preferredSize: Size.fromHeight(kToolbarHeight + 8.0),
        child: Container(
          color: altDarkBlue,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: AppBar(
              brightness: Brightness.light,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  padding: EdgeInsets.only(left: 70.0, right: 25.0),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TabBar(
                          unselectedLabelColor:
                              Colors.deepPurple.withOpacity(0.6),
                          /*indicator: BoxDecoration(
                              border:
                                  Border.all(color: altDeepPurple, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0))),
                          indicatorWeight: 0.0,*/
                          indicatorColor: altDeepPurple,
                          controller: _tabController,
                          tabs: [
                            Tab(
                                child: Text('Send',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0))),
                            Tab(
                                child: Text('Carry',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
              ),
              centerTitle: true,
              leading: IconButton(
                  icon: new AnimatedIcon(
                      size: 30,
                      icon: AnimatedIcons.close_menu,
                      progress: _controller.view),
                  onPressed: _toggleBackdropLayerVisibility
              )
          ),
        ));
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          extendBody: true,
          appBar: appBar,
          body: LayoutBuilder(builder: _buildStack),
          bottomNavigationBar: widget.navbar,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: new AnimatedIcon(
              size: 30,
              icon: AnimatedIcons.add_event,
              progress: _fabAnimationController.view
            ),
            onPressed: _onFloatingActionButtonPressed,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        )
    );
  }
}
