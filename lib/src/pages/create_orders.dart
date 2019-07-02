import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:swingo/src/models/city.dart';
import 'package:swingo/src/models/packet_size.dart';
import 'package:swingo/src/components/sw_button.dart';
import 'package:swingo/src/components/sw_select.dart';
import 'package:swingo/src/components/sw_datepicker.dart';
import 'package:swingo/src/components/sw_formfield.dart';
import 'package:swingo/src/services/order.dart';

class CreateOrderForm {
  //todo: backenddeki fieldlar ile senkron olmalı.
  City fromCity;
  City toCity;
  DateTime fromDate;
  DateTime toDate;
  int weight;
  PacketSize size;
  String comments;
}

class CreateOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CreateOrdersScreen(),
    );
  }
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
  TextEditingController fromCityController = TextEditingController();
  TextEditingController toCityController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var _form = CreateOrderForm();

  void _onFromCitySelected(City fromCity) {
    setState(() => _form.fromCity = fromCity);
    fromCityController.text = fromCity.name;
  }

  void _onToCitySelected(City toCity) {
    setState(() => _form.toCity = toCity);
    toCityController.text = toCity.name;
  }

  void _onFromDateSelected(DateTime fromDate){
    setState(() => _form.fromDate = fromDate);
    fromDateController.text = fromDate.toString();
  }

  void _onToDateSelected(DateTime toDate){
    setState(() => _form.toDate = toDate);
    toDateController.text = toDate.toString();
  }

  void _onPacketSizeSelected(PacketSize size){
    setState(() => _form.size = size);
    sizeController.text = size.name;
  }

  _submit(BuildContext context) {
    if (_formKey.currentState.validate()) {
      OrderService.createSender(
        context,
        from_city: _form.fromCity != null ? _form.fromCity.id : null,
        to_city: _form.toCity != null ? _form.toCity.id : null,
        from_date: _form.fromDate,
        to_date: _form.fromDate,
        price: 5,
        size: _form.size != null ? _form.size.id : null,
        weight: _form.weight,
        comments: _form.comments,
      );
    }
  }

  _onRequestSuccess(BuildContext context) {
    return (response) => Navigator.of(context).pushNamed('/signin');
  }

  List<City> _onSearchChanged(String searchingText) {
    //todo: backendden alınan değer döndürülmeli
    if (searchingText == 'a') {
      return [
        City(id: 0, name: 'İstanbul'),
        City(id: 1, name: 'Ankara'),
        City(id: 2, name: 'Adana'),
        City(id: 3, name: 'İzmir'),
        City(id: 4, name: 'Muğla'),
      ];
    } else if (searchingText == 'b') {
      return [
        City(id: 1, name: 'Ankara'),
        City(id: 2, name: 'Adana'),
        City(id: 3, name: 'İzmir'),
      ];
    } else {
      return [];
    }
  }

  List<PacketSize> _onPacketSizeSearchChanged(String searchingText) {
    return [
      //todo: backendden alınması gerekiyor
      PacketSize(id: 0, name: 'Xsmall'),
      PacketSize(id: 1, name: 'Small'),
      PacketSize(id: 2, name: 'Medium'),
      PacketSize(id: 3, name: 'Large'),
      PacketSize(id: 4, name: 'Xlarge'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
            padding: EdgeInsets.only(
                top: size.width / 20,
                left: size.width / 10,
                right: size.width / 10,
                bottom: size.width / 10),
            child: Center(
              child: Wrap(
                runSpacing: 20,
                children: <Widget>[
                  SwSelect(
                    isRequired: true,
                    prefixIcon: FontAwesomeIcons.planeDeparture,
                    labelText: 'Source City',
                    onSelected: _onFromCitySelected,
                    onSearchChanged: _onSearchChanged,
                    textEditingController: fromCityController,
                  ),
                  SwSelect(
                    isRequired: true,
                    prefixIcon: FontAwesomeIcons.planeArrival,
                    labelText: 'Destination City',
                    onSelected: _onToCitySelected,
                    onSearchChanged: _onSearchChanged,
                    textEditingController: toCityController,
                  ),
                  SwDatePicker(
                    isRequired: true,
                    prefixIcon: FontAwesomeIcons.calendarDay,
                    labelText: 'Date From',
                    onSelected: _onFromDateSelected,
                    textEditingController: fromDateController,
                  ),
                  SwDatePicker(
                    isRequired: true,
                    prefixIcon: FontAwesomeIcons.calendarDay,
                    labelText: 'Date To',
                    onSelected: _onToDateSelected,
                    textEditingController: toDateController,
                  ),
                  SwFormField(
                    isRequired: true,
                    prefixIcon: FontAwesomeIcons.dumbbell,
                    labelText: 'Weight',
                    controller: weightController,
                    isNumber: true,
                  ),
                  SwSelect(
                      isRequired: true,
                      prefixIcon: FontAwesomeIcons.expand,
                      labelText: 'Size',
                      onSelected: _onPacketSizeSelected,
                      onSearchChanged: _onPacketSizeSearchChanged,
                      hideSearchBar: true,
                      textEditingController: sizeController,
                  ),
                  SwFormField(
                    isRequired: true,
                    prefixIcon: FontAwesomeIcons.infoCircle,
                    labelText: 'Comments',
                    controller: commentsController,
                    maxLines: 3,
                  ),
                  Center(
                      child: SwButton(
                    text: 'Create',
                    fillParent: true,
                    onPressed: () => _submit(context),
                  )),
                ],
              ),
            )),
      ),
    );
  }
}
