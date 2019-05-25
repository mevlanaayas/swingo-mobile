import 'package:flutter/foundation.dart';

class City {
  const City({
    @required this.id,
    @required this.name,
  })  : assert(id != null),
        assert(name != null);

  final int id;
  final String name;
}
