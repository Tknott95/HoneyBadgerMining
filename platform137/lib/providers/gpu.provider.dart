import 'package:flutter/material.dart';

/* refactor this into a type */
class GPUProvider with ChangeNotifier {
  /* default will always be one */
  int _numOfGPUs = 1;

  int get numOfGPUs => _numOfGPUs;

  void setAmtOfGPUS(int _gpuCount) {
    _numOfGPUs = _gpuCount;
    notifyListeners();
  }

}