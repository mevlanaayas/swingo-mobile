import 'package:flutter/material.dart';

import 'package:swingo/src/models/city.dart';
import 'package:swingo/src/components/sw_select.dart';

class CreateOrdersScreen extends StatefulWidget {
  @override
  CreateOrdersScreenState createState() {
    return CreateOrdersScreenState();
  }
}

class CreateOrdersScreenState extends State<CreateOrdersScreen> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  City selectedCity;
  List<City> cities = <City>[ //TODO: backend den alınması gerekiyor.
    City(id: 1, name:'Trabzon'),
    City(id: 2, name:'Kadıköy'),
    City(id: 3, name:'Marmara'),
  ];

  void _onDropDownChanged(City city){
      setState(() {
        selectedCity = city;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 10),
              child: Center(
                child: Wrap(
                  runSpacing: 20,
                  children: <Widget>[
                    SwSelect(
                      list: cities,
                      prefixIcon: Icon(Icons.flight_takeoff),
                      labelText: 'Meeting City',
                      onChanged: _onDropDownChanged,
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                          labelText: 'Destination City',
                          prefixIcon: Icon(
                              Icons.flight_land
                          )
                      ),
                    ),
                    Center(
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, we want to show a Snackbar
                            print('valid data');
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
              )
            ),
          )
      ),
    );
  }
}
