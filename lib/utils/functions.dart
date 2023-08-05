import 'package:intl/intl.dart';

String formatIntToDateString(int time,int timeZone){
  DateTime date=DateTime.fromMillisecondsSinceEpoch(isUtc: false,time*1000).toUtc();
  DateTime actualDate=date.add(Duration(seconds: timeZone));
  String formattedString=DateFormat("h:mm a").format(actualDate);
  return formattedString;
}