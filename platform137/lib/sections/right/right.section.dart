
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
        children: const <Widget>[
          SliderWidgetPower(),
          SliderWidgetTempThresh(),
          Divider(),
          SliderWidgetFans(),
          Divider(),
          SliderWidgetMemory(),
          SliderWidgetGraphics()
        ]
      ),
    );
  }
}
