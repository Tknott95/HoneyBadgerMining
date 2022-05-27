import 'package:flutter/material.dart';
import 'package:process_run/shell_run.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void nvidia_set_fans(int fansVal) {
  var shell = Shell();
  
  final fansParam = "1:"+fansVal.toString();
  /* rmvd sudo on fans */
  shell.run("""
    #!/bin/bash
    ./nvidia_set.sh -f $fansParam
    """).then((result){
      print('Shell script done!');
    }).catchError((onError) {
      print('Shell.run error!');
      print(onError);
    });
}

class SliderWidgetFans extends StatefulWidget {
  const SliderWidgetFans({Key? key}) : super(key: key);

  @override
  State<SliderWidgetFans> createState() => _SliderWidgetStateFans();
}

class _SliderWidgetStateFans extends State<SliderWidgetFans> {
  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      min: 30,
      max: 70,
      initialValue: 37,
      innerWidget: (sliderValue) => Center(child: Text(sliderValue.toStringAsFixed(0)+"%"),),
      appearance: CircularSliderAppearance(),
      onChange: (double value) {
        nvidia_set_fans(value.round());
      }
    );
  }
}