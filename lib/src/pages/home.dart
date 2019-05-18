import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Wallet',
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(fontWeight: FontWeight.w700)),
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
