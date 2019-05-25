import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:swingo/src/theme/colors.dart';
import 'package:swingo/src/models/filter.dart';
import 'package:swingo/src/models/city.dart';


class FilterMenuPage extends StatelessWidget {
  final Filter currentFilter;
  final ValueChanged<Filter> onFilterChange;

  FilterMenuPage({
    Key key,
    @required this.currentFilter,
    @required this.onFilterChange,
  })  : assert(currentFilter != null),
        assert(onFilterChange != null);


  Widget _buildFilter(Widget filter, BuildContext context) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          SizedBox(height: 16.0),
          filter,
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _filters = [
      FromCity(currentFilter: this.currentFilter, onFilterChange: this.onFilterChange),
      FromDate(currentFilter: this.currentFilter, onFilterChange: this.onFilterChange)
    ];
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 40.0),
        color: altDarkBlue,
        child: ListView(
            children: _filters
                .map((Widget w) => _buildFilter(w, context))
                .toList()),
      ),
    );
  }
}



class FromDate extends StatefulWidget{
 final Filter currentFilter;
 final ValueChanged<Filter> onFilterChange;

 FromDate({
   Key key,
   @required this.currentFilter,
   @required this.onFilterChange
 }) : assert(currentFilter != null),
      assert(onFilterChange != null);

  _FromDateState createState() => _FromDateState();
}

class _FromDateState extends State<FromDate>{
  String _value = '';
  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2020)
    );
    if(picked != null){
      setState(() {
        _value = picked.toString();
        widget.currentFilter.fromDate = _value;
        widget.onFilterChange(widget.currentFilter);
      });;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
        onPressed: _selectDate,
        child: Text('Click Me!')
    );
  }
}


class FromCity extends StatefulWidget{
  final Filter currentFilter;
  final ValueChanged<Filter> onFilterChange;

  FromCity({
    Key key,
    @required this.currentFilter,
    @required this.onFilterChange,
  })  : assert(currentFilter != null),
        assert(onFilterChange != null);

  @override
  _FromCityState createState() => _FromCityState();
}

class _FromCityState extends State<FromCity>{
  City selectedCity;
  List<City> cities = <City>[
    City(id: 1, name:'Trabzon'),
    City(id: 2, name:'Kadıköy'),
    City(id: 3, name:'Marmara'),
  ];

  @override
  void initState() {
    selectedCity = cities[0];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: EdgeInsets.only(top: 40.0),
            color: altDarkBlue,
            child: DropdownButton<City>(
              value: selectedCity,
              onChanged: (City newValue) {
                setState(() {
                  selectedCity = newValue;
                  widget.currentFilter.fromCity = newValue.id;
                  widget.onFilterChange(widget.currentFilter);
                });
              },
              items: cities
                  .map<DropdownMenuItem<City>>((City city) {
                return DropdownMenuItem<City>(
                  value: city,
                  child: Text(city.name),
                );
              })
                  .toList(),
            )
        )
    );
  }
}