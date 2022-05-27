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
    return Column(
              children: [
                Text(
                  'FANS',
                  style: Theme.of(context).textTheme.headline6
                ),
                SleekCircularSlider(
                  min: 30,
                  max: 70,
                  initialValue: 37,
                  innerWidget: (sliderValue) => Center(
                    child: Text(
                        sliderValue.toStringAsFixed(0)+"%",
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ),
                  appearance: CircularSliderAppearance(
                    size: 85,
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
                    nvidia_set_fans(value.round());
                  }
                )
              ],
    );
  }
}
