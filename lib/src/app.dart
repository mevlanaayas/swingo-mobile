import 'package:flutter/material.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/theme/themes.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  RouterBloc _router;

  @override
  void initState() {
    _router = RouterBloc();
    _router.dispatch(PushIndex());
    super.initState();
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider<RouterBloc>(
      bloc: _router,
      child: MaterialApp(
        home: BlocBuilder<RouterEvent, RouterState>(
          bloc: _router,
          builder: (BuildContext context, RouterState state) {
            if (state is Index) {
              return IndexPage();
            } else if (state is Home) {
              return HomePage(state.user);
            } else if (state is Login) {
              return LoginPage();
            } else if (state is Register) {
              return RegisterPage();
            }
          },
        ),
        theme: myTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
