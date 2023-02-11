import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time = "";
  String flag;
  String url;
  bool isDaytime = true; // true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      int rawOffset = data['raw_offset'];

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(seconds: rawOffset));

      // set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print(e);
      time = 'Could not get time';
    }
  }

}