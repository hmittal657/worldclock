import 'package:flutter/material.dart';
import 'package:worldclock/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String location = "";
  String flag = "";
  String time = "";
  bool isDaytime = true;

  Future<void> setupWorldTime() async {
    WorldTime instance = WorldTime(location: 'New Delhi', flag: 'india.png', url: 'Asia/Kolkata');
    await instance.getTime();
    location = instance.location;
    flag = instance.flag;
    time = instance.time;
    isDaytime = instance.isDaytime;
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime().then((value) => {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': location,
        'flag': flag,
        'time': time,
        'isDaytime': isDaytime,
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
            size: 50,
        ),
      ),
    );
  }
}
