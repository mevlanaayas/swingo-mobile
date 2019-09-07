import 'package:intl/intl.dart';
import 'package:swingo/src/utils/constans.dart';

getStatusKey(String status) {
  return status.toUpperCase().replaceAll(' ', '_');
}

isSender(String userType){
  return ORDER_OWNER_TYPES['SENDER'] == userType;
}

formatDate(DateTime dateTime, {String format='yyyy-MM-dd'}){
  return DateFormat(format).format(dateTime);
}