import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage(this._user);

  final User _user;

  @override
  Widget build(BuildContext context) {
    final Graphql graphql = Graphql();

    graphql.register('26a899667a9fc112f18461c2b440dfa041de5d24567c9bf1');

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Wallet',
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(fontWeight: FontWeight.w700)),
      ),
      body: GraphqlProvider(
        client: graphql.client,
        child: TestPage(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
              title: Text('A'), icon: Icon(Icons.arrow_drop_up)),
          BottomNavigationBarItem(title: Text('B'), icon: Icon(Icons.history)),
          BottomNavigationBarItem(
              title: Text('C'), icon: Icon(Icons.add_to_queue)),
        ],
      ),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({
    Key key,
  }) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text(
            'Transaction List',
            style: Theme.of(context)
                .textTheme
                .headline
                .copyWith(fontWeight: FontWeight.w700),
          ),
          Expanded(
            child: Query(
              'query  { Transaction { id from to date } }',
              builder: ({
                bool loading,
                Map data,
                Exception error,
              }) {
                if (error != null) {
                  return Text(error.toString());
                }

                if (loading) {
                  return Text('Loading');
                }

                final feedList = data['Transaction'];

                return ListView.builder(
                  itemCount: feedList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final feedListItems = feedList[index];
                    // List tagList = feedListItems['name'];
                    return Card(
                      margin: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: Text(feedListItems.toString()),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
