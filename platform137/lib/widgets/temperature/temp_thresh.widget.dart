/* THRESHOLD WIDGET */
import 'package:flutter/material.dart';
import 'package:process_run/shell_run.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void nvidia_set_temp_threshold(double powerVal) {
  var shell = Shell();

  shell.run("""
    #!/bin/bash
    sudo ./nvidia_set.sh -t $powerVal
    """).then((result){
      print('Shell script done!');
    }).catchError((onError) {
      print('Shell.run error!');
      print(onError);
    });
}

class SliderWidgetTempThresh extends StatefulWidget {
  const SliderWidgetTempThresh({Key? key}) : super(key: key);

  @override
  State<SliderWidgetTempThresh> createState() => _SliderWidgetStateTempThresh();
}

class _SliderWidgetStateTempThresh extends State<SliderWidgetTempThresh> {
  @override
  Widget build(BuildContext context) {
    return  Column(
              children: [
                Text(
                  'POWER',
                  style: Theme.of(context).textTheme.headline6
                ),
                SleekCircularSlider(
                  min: 110,
                  max: 140,
                  initialValue: 115,
                  innerWidget: (sliderValue) => Center(
                    child: Text(
                        sliderValue.toStringAsFixed(3)+"W",
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ),
                  appearance: CircularSliderAppearance(
                    size: 85,
                     customWidths: CustomSliderWidths(
                      //handlerSize: 20,
                      trackWidth: 1,
                      //shadowWidth: 0,
                      progressBarWidth: 11,
                    ),
                    customColors: CustomSliderColors(
                      dotColor: const Color.fromARGB(175, 255, 255, 255)/*Theme.of(context).primaryColor*/,
                      trackColor: const Color.fromARGB(172, 153, 153, 153),
                      progressBarColors: const [
                      Color.fromARGB(255, 240, 40, 13),
                      Color.fromARGB(255, 238, 169, 20),
                      Color.fromARGB(255, 6, 49, 105),
                      Color.fromARGB(255, 45, 192, 180),
                      ],
                     shadowColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  onChange: (double value) {
                    nvidia_set_temp_threshold(value);
                  }
                )
              ],
            );
  }
}
