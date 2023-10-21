import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final bool initNow;
  const TimerWidget({super.key,required this.initNow});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Duration duration = Duration();
  Timer? timer;
  startNow(){
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        duration = Duration(seconds: duration.inSeconds + 1);
      });
    });
  }
  stopNow(){
    setState(() {
      timer?.cancel();
      timer = null;
      duration = Duration();
    });
  }
  @override
  Widget build(BuildContext context) {
    if(timer == null || !widget.initNow){
      widget.initNow ? startNow() : stopNow();
    }
    String towDigit(int number) => number.toString().padLeft(2,"");
    final minutes = towDigit(duration.inMinutes.remainder(60));
    final hours = towDigit(duration.inHours.remainder(60));
    final seconds = towDigit(duration.inSeconds.remainder(60));
    return Text("$hours: $minutes: $seconds",style: TextStyle(fontSize: 23,color: Theme.of(context).textTheme.titleLarge!.color,));
  }
}
