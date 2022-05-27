import 'package:flutter/material.dart';
import 'package:process_run/shell_run.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void nvidia_set_power(double powerVal) {
  var shell = Shell();

  shell.run("""
    #!/bin/bash
    sudo ./nvidia_set.sh -p $powerVal
    """).then((result){
      print('Shell script done!');
    }).catchError((onError) {
      print('Shell.run error!');
      print(onError);
    });
}

class SliderWidgetPower extends StatefulWidget {
  const SliderWidgetPower({Key? key}) : super(key: key);

  @override
  State<SliderWidgetPower> createState() => _SliderWidgetStatePower();
}

class _SliderWidgetStatePower extends State<SliderWidgetPower> {
  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      min: 110,
      max: 140,
      initialValue: 115,
      innerWidget: (sliderValue) => Center(
        child: Text(
            sliderValue.toStringAsFixed(3)+"W",
            style: Theme.of(context).textTheme.bodyText1,
          )
        ),
      appearance: CircularSliderAppearance(),
      onChange: (double value) {
        nvidia_set_power(value);
      }
    );
  }
}