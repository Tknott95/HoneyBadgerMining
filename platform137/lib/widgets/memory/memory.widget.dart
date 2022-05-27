


// MEMORY - @TODO abstact into widget module
import 'package:flutter/material.dart';
import 'package:process_run/shell_run.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void nvidia_set_memory_clock(int val) {
  var shell = Shell();

  shell.run("""
    #!/bin/bash
    ./nvidia_set.sh -m $val
    """).then((result){
      print('Shell script done!');
    }).catchError((onError) {
      print('Shell.run error!');
      print(onError);
    });
}

class SliderWidgetMemory extends StatefulWidget {
  const SliderWidgetMemory({Key? key}) : super(key: key);

  @override
  State<SliderWidgetMemory> createState() => _SliderWidgetStateMemory();
}

class _SliderWidgetStateMemory extends State<SliderWidgetMemory> {
  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      min: 0,
      max: 650,
      initialValue: 10,
      innerWidget: (sliderValue) => Center(child: Text(sliderValue.toStringAsFixed(0)+" CLOCK"),),
      appearance: CircularSliderAppearance(),
      onChange: (double value) {
        nvidia_set_memory_clock(value.round());
      }
    );
  }
}