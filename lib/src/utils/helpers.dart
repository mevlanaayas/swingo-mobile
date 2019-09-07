import 'package:swingo/src/utils/constans.dart';

getStatusKey(String status) {
  return status.toUpperCase().replaceAll(' ', '_');
}

isSender(String userType){
  return ORDER_OWNER_TYPES['SENDER'] == userType;
}