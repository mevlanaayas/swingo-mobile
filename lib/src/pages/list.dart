import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swingo/src/theme/colors.dart';

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
    return ListView.builder(
      padding: const EdgeInsets.all(3.0),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 1.0,
          child: InkWell(
            splashColor: altDeepPurple,
            onTap: () {
              print('Card tapped. ${index}');
            },
            child: Container(
              width: 300.0,
              height: 120.0,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                        height: 10.0, child: Icon(Icons.ac_unit, size: 15.0, color: altDeepPurple)),
                    SizedBox(height: 10.0),
                    Text('From city: ${entries[index]}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0)),
                    Text('To city: ${entries[index]}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
