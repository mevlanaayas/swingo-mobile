import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/components/components.dart';

import 'package:swingo/src/models/city.dart';
import 'package:swingo/src/models/packet_size.dart';
import 'package:swingo/src/components/sw_select.dart';
import 'package:swingo/src/components/sw_datepicker.dart';
import 'package:swingo/src/components/sw_formfield.dart';
import 'package:swingo/src/services/option.dart';
import 'package:swingo/src/services/order.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/constans.dart';
import 'package:swingo/src/utils/helpers.dart';

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

class CreateOrders extends StatelessWidget with SwScreen {
  final String type;

  CreateOrders(this.type);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.buildAppbar(
        context,
        title: this.type,
      ),
      body: SwPage(
        child: CreateOrdersScreen(
          type: this.type,
        ),
      ),
    );
  }
}

class CreateOrdersScreen extends StatefulWidget {
  final String type;

  CreateOrdersScreen({
    this.type,
  });

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
  TextEditingController priceController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var _form = CreateOrderForm();

  final stepperLength = 2;
  int currentStepIndex = 0;

  @override
  void dispose() {
    super.dispose();
  }

  void _onFromCitySelected(City fromCity) {
    setState(() => _form.fromCity = fromCity);
    fromCityController.text = fromCity.name;
  }

  void _onToCitySelected(City toCity) {
    setState(() => _form.toCity = toCity);
    toCityController.text = toCity.name;
  }

  void _onFromDateSelected(DateTime fromDate) {
    setState(() => _form.fromDate = fromDate);
    fromDateController.text = formatDate(fromDate);
  }

  void _onToDateSelected(DateTime toDate) {
    setState(() => _form.toDate = toDate);
    toDateController.text = formatDate(toDate);
  }

  void _onPacketSizeSelected(PacketSize size) {
    setState(() => _form.size = size);
    sizeController.text = size.name;
  }

  _submit(BuildContext context) {
    if (_formKey.currentState.validate()) {
      if (widget.type == "Send") {
        OrderService.createSender(
          context,
          from_city: _form.fromCity.cityId,
          to_city: _form.toCity.cityId,
          from_date: _form.fromDate,
          to_date: _form.fromDate,
          price: int.parse(priceController.text),
          size: _form.size.id,
          weight: int.parse(weightController.text),
          comments: _form.comments,
          onSuccess: _onRequestSuccess(context),
        );
      } else {
        OrderService.createCarrier(
          context,
          from_city: _form.fromCity.cityId,
          to_city: _form.toCity.cityId,
          from_date: _form.fromDate,
          to_date: _form.fromDate,
          size: _form.size.id,
          weight: int.parse(weightController.text),
          comments: _form.comments,
          onSuccess: _onRequestSuccess(context),
        );
      }
    }
  }

  _onRequestSuccess(BuildContext context) {
    return (responseData) {
      int nextNavBarIndex = 1; // My Orders Index
      Navigator.of(context).pop(nextNavBarIndex);
    };
  }

  _onSearchChanged(BuildContext context, String searchingText) async {
    print(searchingText);
    final response = await OptionService.listCities(
      context,
      searchingText: searchingText,
      page: 0,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body);
      final cityJsonArray = responseData['results'];
      print(cityJsonArray);
      return List<City>.from(
          cityJsonArray.map((orderJson) => City.fromJson(orderJson)));
    }
    return [];
  }

  _buildStepperContent(List<Widget> content) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topCenter,
        child: Wrap(
          runSpacing: formSpacing,
          children: content,
        ),
      ),
    );
  }

  _buildTripDetails() {
    return [
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
    ];
  }

  _buildPacketDetails() {
    return [
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
        list: PACKET_SIZES,
        hideSearchBar: true,
        textEditingController: sizeController,
      ),
      widget.type == "Send"
          ? SwFormField(
              isRequired: true,
              prefixIcon: FontAwesomeIcons.moneyBill,
              labelText: 'Price To Pay',
              controller: priceController,
              isNumber: true,
            )
          : SizedBox(),
      SwFormField(
        isRequired: true,
        prefixIcon: FontAwesomeIcons.infoCircle,
        labelText: 'Comments',
        controller: commentsController,
        maxLines: 3,
      )
    ];
  }

  StepState _setStepState(int currentStepIndex, int stepIndex) {
    StepState stepState;
    if (currentStepIndex < stepIndex) {
      stepState = StepState.disabled;
    } else if (currentStepIndex == stepIndex) {
      stepState = StepState.editing;
    } else {
      stepState = StepState.complete;
    }
    return stepState;
  }

  bool _setStepActiveValue(int currentStepIndex, int stepIndex) {
    return currentStepIndex != stepIndex ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Theme(
          data: ThemeData(
            primaryColor: primaryColor,
            canvasColor: Colors.white,
          ),
          child: Stepper(
            currentStep: currentStepIndex,
            type: StepperType.horizontal,
            steps: [
              Step(
                state: _setStepState(this.currentStepIndex, 0),
                isActive: _setStepActiveValue(this.currentStepIndex, 0),
                title: Text('Trip Details'),
                content: _buildStepperContent(_buildTripDetails()),
              ),
              Step(
                state: _setStepState(this.currentStepIndex, 1),
                isActive: _setStepActiveValue(this.currentStepIndex, 1),
                title: Text('Packet Details'),
                content: _buildStepperContent(_buildPacketDetails()),
              ),
            ],
            onStepContinue: () {
              if (this.currentStepIndex < this.stepperLength - 1) {
                if (!_formKey.currentState.validate()) {
                  return;
                } else {
                  setState(() {
                    this.currentStepIndex = currentStepIndex + 1;
                  });
                }
              } else {
                _submit(context);
              }
            },
            onStepCancel: () {
              setState(() {
                if (this.currentStepIndex > 0) {
                  this.currentStepIndex = currentStepIndex - 1;
                }
              });
            },
            controlsBuilder: (
              BuildContext context, {
              VoidCallback onStepContinue,
              VoidCallback onStepCancel,
            }) {
              return Padding(
                padding: EdgeInsets.only(top: swPadding),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    this.currentStepIndex > 0
                        ? SwButton(
                            color: primaryColor,
                            text: 'Back',
                            onPressed: onStepCancel,
                          )
                        : SizedBox(),
                    SwButton(
                      color: primaryColor,
                      text: this.currentStepIndex == stepperLength - 1
                          ? 'Submit'
                          : 'Next',
                      onPressed: onStepContinue,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
