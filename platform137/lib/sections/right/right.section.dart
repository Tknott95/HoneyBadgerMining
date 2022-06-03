
import 'package:flutter/material.dart';
import 'package:platform137/widgets/fans/fans.widget.dart';
import 'package:platform137/widgets/graphics/graphics.widget.dart';
import 'package:platform137/widgets/memory/memory.widget.dart';
import 'package:platform137/widgets/power/power.widget.dart';
import 'package:platform137/widgets/temperature/temp_thresh.widget.dart';

class RightSection extends StatelessWidget {
  const RightSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
     
         
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SliderWidgetPower(gpuIndex: 0),
              SizedBox(width: 5),
              SliderWidgetPower(gpuIndex: 1),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SliderWidgetTempThresh(gpuIndex: 0),
              SizedBox(width: 5),
              SliderWidgetTempThresh(gpuIndex: 1),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SliderWidgetFans(gpuIndex: 0),
              SizedBox(width: 5),
              SliderWidgetFans(gpuIndex: 1),
            ],
          ),
          const Divider(),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SliderWidgetMemory(gpuIndex: 0),
              SizedBox(width: 5),
              SliderWidgetMemory(gpuIndex: 1),
            ],
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SliderWidgetGraphics(gpuIndex: 0),
              SizedBox(width: 5),
              SliderWidgetGraphics(gpuIndex: 1),
            ],
          ),
        ]
      ),
    );
  }
}
