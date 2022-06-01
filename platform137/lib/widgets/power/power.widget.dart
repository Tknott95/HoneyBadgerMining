import 'package:flutter/material.dart';
import 'package:process_run/shell_run.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void nvidia_set_power(int _gpuIndex, double _powerVal) {
  var shell = Shell();

  shell.run("""
    #!/bin/bash
    sudo ./nvidia_set.sh -p $_gpuIndex:$_powerVal
    """).then((result){
      print('Shell script done!');
    }).catchError((onError) {
      print('Shell.run error!');
      print(onError);
    });
}

class SliderWidgetPower extends StatefulWidget {
  final gpuIndex;
  const SliderWidgetPower({Key? key, @required this.gpuIndex}) : super(key: key);

  @override
  State<SliderWidgetPower> createState() => _SliderWidgetStatePower();
}

class _SliderWidgetStatePower extends State<SliderWidgetPower> {
  var gpuIndex;
  @override
  void initState() {
    gpuIndex = widget.gpuIndex;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
              children: [
                Text(
                  'GPU_$gpuIndex POWER',
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
                    nvidia_set_power(gpuIndex, value);
                    // nvidia_set_power(1, value);
                  }
                )
              ],
            );
  }
}

