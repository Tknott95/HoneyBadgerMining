

import 'package:flutter/material.dart';
import 'package:process_run/shell_run.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void nvidia_set_graphics_clock(int val) {
  var shell = Shell();

  shell.run("""
    #!/bin/bash
    ./nvidia_set.sh -g $val
    """).then((result){
      print('Shell script done!');
    }).catchError((onError) {
      print('Shell.run error!');
      print(onError);
    });
}

class SliderWidgetGraphics extends StatefulWidget {
  const SliderWidgetGraphics({Key? key}) : super(key: key);

  @override
  State<SliderWidgetGraphics> createState() => _SliderWidgetStateGraphics();
}

class _SliderWidgetStateGraphics extends State<SliderWidgetGraphics> {
  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      min: 0,
      max: 80,
      initialValue: 5,
      innerWidget: (sliderValue) => Center(child: Text(sliderValue.toStringAsFixed(0)+" CLOCK"),),
      appearance: CircularSliderAppearance(),
      onChange: (double value) {
        nvidia_set_graphics_clock(value.round());
      }
    );
  }
}