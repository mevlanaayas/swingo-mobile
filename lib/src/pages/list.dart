import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swingo/src/theme/colors.dart';
import 'package:swingo/src/components/sw_button.dart';
import 'package:swingo/src/pages/chat.dart';

class ListPage extends StatelessWidget {
  final List<String> entries = <String>[
    'Lisbon',
    'Bursa',
    'Canada',
    'Trabzon',
    'Mersin',
    'Dublin',
    'Lisbon'
  ];

  ListPage();

  @override
  Widget build(BuildContext context) {
    Widget _buildCardLeading(){
      return Container(
        padding: EdgeInsets.only(
            right: 12.0
        ),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(
                    width: 1.0,
                    color: Colors.deepPurple
                )
            )
        ),
        child: Icon(
            Icons.flight,
            color: Colors.deepPurple
        ),
      );
    }

    Widget _buildCardTitle(int index){
      return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column( //özet bilgiler sütunu
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row( // özet bilgi
                  children: <Widget>[
                    Text(entries[index]), //TODO: veri response'dan alınacak
                    Icon(Icons.keyboard_arrow_right, size:16),
                    Icon(Icons.keyboard_arrow_right, size:16),
                    Icon(Icons.keyboard_arrow_right, size:16),
                    Text(entries[index]), //TODO: veri response'dan alınacak
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('2019-04-01 ~ 2019-04-01', style: TextStyle(fontSize: 12),) //TODO: veri response'dan alınacak
                  ],
                )
              ],
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.centerRight,
                  child: Text('95\$', style: TextStyle(fontSize: 25),) //TODO: veri response'dan alınacak
              ),
            )
          ]
      );
    }

    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.black,
        height: 0,
      ),
      //padding: const EdgeInsets.all(5.0),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.all(0),
          elevation: 1.0,
          child: Container(
            padding: new EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: ExpansionTile(
              leading: _buildCardLeading(),
              title: _buildCardTitle(index),
              children: <Widget>[
                Text('Tirabzondan taze hamsiye ihtiyacım var. Bir de finduk.'),
                SwButton(
                  text: 'Make a Bid',
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatPage()),
                    );
                  },
                ),
              ],
            ),
          )
        );
      },
    );
  }
}
