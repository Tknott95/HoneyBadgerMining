import 'package:flutter/material.dart';

/* refactor this into a type */
class GPUProvider extends ChangeNotifier {
  /* default will always be one */
  int numOfGPUs = 0;

  // int get numOfGPUs => _numOfGPUs;

  /* nvidia-smi --list-gpus | wc -l */
  void setAmtOfGPUS(int _gpuCount) {
    numOfGPUs = _gpuCount;
    notifyListeners();
  }
}