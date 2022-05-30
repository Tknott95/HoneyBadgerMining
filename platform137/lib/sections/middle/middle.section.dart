
import 'package:flutter/material.dart';

class MiddleSection extends StatelessWidget {
  const MiddleSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'mining here',
        style: Theme.of(context).textTheme.headline1
      )
    );
  }
}
