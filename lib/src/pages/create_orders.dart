import 'package:flutter/material.dart';

import 'package:swingo/src/models/city.dart';
import 'package:swingo/src/models/packet_size.dart';
import 'package:swingo/src/components/sw_button.dart';
import 'package:swingo/src/components/sw_select.dart';
import 'package:swingo/src/components/sw_datepicker.dart';
import 'package:swingo/src/components/sw_formfield.dart';

class CreateOrderForm{ //todo: backenddeki fieldlar ile senkron olmalı.
  City fromCity;
  City toCity;
  DateTime fromDate;
  DateTime toDate;
  int weight;
  PacketSize size;
  String details;
}

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
  var _form = CreateOrderForm();

  void _onFromCitySelected(City fromCity) => setState(() => _form.fromCity = fromCity);

  void _onToCitySelected(City toCity) => setState(() => _form.toCity = toCity);

  void _onFromDateSelected(DateTime fromDate) => setState(() => _form.fromDate = fromDate);

  void _onToDateSelected(DateTime toDate) => setState(() => _form.toDate = toDate);

  void _onWeightEditingCompleted(String weight) => setState(() => _form.weight = int.parse(weight));

  void _onPacketSizeSelected(PacketSize size) => setState(() => _form.size = size);

  void _onDetailsEditingCompleted(String details) => setState(() => _form.details = details);

  List<City> _onSearchChanged(String searchingText){ //todo: backendden alınan değer döndürülmeli
    if(searchingText == 'a'){
      return [
        City(id: 0, name: 'İstanbul'),
        City(id: 1, name: 'Ankara'),
        City(id: 2, name: 'Adana'),
        City(id: 3, name: 'İzmir'),
        City(id: 4, name: 'Muğla'),
      ];
    } else if(searchingText == 'b'){
      return [
        City(id: 1, name: 'Ankara'),
        City(id: 2, name: 'Adana'),
        City(id: 3, name: 'İzmir'),
      ];
    } else {
      return [];
    }
  }

  List<PacketSize> _onPacketSizeSearchChanged(String searchingText){
    return [ //todo: backendden alınması gerekiyor
      PacketSize(id: 0, name: 'Xsmall'),
      PacketSize(id: 1, name: 'Small'),
      PacketSize(id: 2, name: 'Medium'),
      PacketSize(id: 3, name: 'Large'),
      PacketSize(id: 4, name: 'Xlarge'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 10),
              child: Center(
                child: Wrap(
                  runSpacing: 20,
                  children: <Widget>[
                    SwSelect(
                      prefixIcon: Icons.flight_takeoff,
                      labelText: 'Source City',
                      onSelected: _onFromCitySelected,
                      onSearchChanged: _onSearchChanged,
                      text: (_form.fromCity != null) ? _form.fromCity.name : ''
                    ),
                    SwSelect(
                        prefixIcon: Icons.flight_land,
                        labelText: 'Destination City',
                        onSelected: _onToCitySelected,
                        onSearchChanged: _onSearchChanged,
                        text: (_form.toCity != null) ? _form.toCity.name : ''
                    ),
                    SwDatePicker(
                        prefixIcon: Icons.date_range,
                        labelText: 'Date From',
                        onSelected: _onFromDateSelected,
                        text: (_form.fromDate != null) ? _form.fromDate.toString() : ''
                    ),
                    SwDatePicker(
                        prefixIcon: Icons.date_range,
                        labelText: 'Date To',
                        onSelected: _onToDateSelected,
                        text: (_form.toDate != null) ? _form.toDate.toString() : ''
                    ),
                    SwFormField(
                        prefixIcon: Icons.functions,
                        labelText: 'Weight',
                        onEditingCompleted: _onWeightEditingCompleted,
                        isNumber: true,
                    ),
                    SwSelect(
                        prefixIcon: Icons.linear_scale,
                        labelText: 'Size',
                        onSelected: _onPacketSizeSelected,
                        onSearchChanged: _onPacketSizeSearchChanged,
                        hideSearchBar: true,
                        text: (_form.size != null) ? _form.size.name : ''
                    ),
                    SwFormField(
                      prefixIcon: Icons.event_note,
                      labelText: 'Details',
                      onEditingCompleted: _onDetailsEditingCompleted,
                    ),
                    Center(
                      child: SwButton(
                        text: 'Create',
                        fillParent: true,
                        onPressed: () {
                          if (_formKey.currentState.validate()) { //Todo: backende yollanacak
                            // If the form is valid, we want to show a Snackbar
                            print('valid data');
                          }
                        },
                      )
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
