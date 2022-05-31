


// MEMORY - @TODO abstact into widget module
import 'package:flutter/material.dart';
import 'package:process_run/shell_run.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void nvidia_set_memory_clock(int _gpuIndex, int _val) {
  var shell = Shell();

  shell.run("""
    #!/bin/bash
    ./nvidia_set.sh -m $_gpuIndex:$_val
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
    return Column(
              children: [
                Text(
                  'MEMORY  CLOCKING',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SleekCircularSlider(
                  min: 0,
                  max: 650,
                  initialValue: 10,
                  innerWidget: (sliderValue) => Center(
                    child: Text(
                        "+"+sliderValue.toStringAsFixed(0),
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ),
                  appearance: CircularSliderAppearance(
                    size: 85,
                    customColors: CustomSliderColors(
                      dotColor: const Color.fromARGB(175, 255, 255, 255)/*Theme.of(context).primaryColor*/,
                      trackColor: Color.fromARGB(172, 0, 0, 0),
                      progressBarColors: const [
                      Color.fromARGB(255, 240, 40, 13),
                      Color.fromARGB(255, 238, 169, 20),
                      Color.fromARGB(255, 8, 63, 3),
                      Color.fromARGB(255, 50, 192, 45),
                      ],
                     shadowColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  onChange: (double value) {
                    nvidia_set_memory_clock(0, value.round());
                  }
                ),
              ],
      );
  }
}
