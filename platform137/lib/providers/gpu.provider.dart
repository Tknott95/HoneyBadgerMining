import 'package:flutter/material.dart';

/* refactor this into a type */
class GPUProvider extends ChangeNotifier {
  /* default will always be one */
  int _numOfGPUs = 2;

  int get numOfGPUs => _numOfGPUs;

  /* nvidia-smi --list-gpus | wc -l */
  void setAmtOfGPUS(int _gpuCount) {
    _numOfGPUs = _gpuCount;
    notifyListeners();
  }
}