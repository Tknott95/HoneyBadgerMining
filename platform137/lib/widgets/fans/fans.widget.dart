import 'package:flutter/material.dart';
import 'package:process_run/shell_run.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void nvidia_set_fans(int _fanIndex, int _fansVal) {
  var shell = Shell();
  
  final fansParam = "$_fanIndex:$_fansVal";
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
  final gpuIndex;
  const SliderWidgetFans({Key? key, @required this.gpuIndex}) : super(key: key);

  @override
  State<SliderWidgetFans> createState() => _SliderWidgetStateFans();
}

class _SliderWidgetStateFans extends State<SliderWidgetFans> {
  var gpuIndex;
  void initState() {
    gpuIndex = widget.gpuIndex;

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
                Text(
                  'GPU_$gpuIndex FANS CTRL',
                  style: Theme.of(context).textTheme.headline6
                ),
                SleekCircularSlider(
                  min: 30,
                  max: 90,
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
                    if(gpuIndex == 0) {
                      /* @TODO make an alg to index fans by gpu - no query atm has been found, yet */
                      nvidia_set_fans(2, value.round());
                    } else {
                      nvidia_set_fans(1, value.round());
                      nvidia_set_fans(0, value.round());
                    }
                  }
                )
              ],
    );
  }
}
