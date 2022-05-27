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
                    //  customWidths: CustomSliderWidths(
                    //   handlerSize: 20,
                    //   trackWidth: 10,
                    //   shadowWidth: 0,
                    //   progressBarWidth: 10,
                    // ),
                    customColors: CustomSliderColors(
                      dotColor: const Color.fromARGB(175, 255, 255, 255)/*Theme.of(context).primaryColor*/,
                      trackColor:Color.fromARGB(172, 8, 30, 109),
                      // progressBarColor: Color.fromARGB(174, 0, 0, 0),
                      progressBarColors: [
                      Color.fromARGB(255, 86, 255, 77),
                      Color.fromARGB(255, 34, 152, 230),
                      Color.fromARGB(255, 0, 11, 75),
                      Color.fromARGB(255, 238, 169, 20),
                    ],
                  ),
                  ),
                  onChange: (double value) {
                    nvidia_set_power(value);
                  }
                )
              ],
            );
  }
}

