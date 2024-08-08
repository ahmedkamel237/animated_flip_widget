import 'package:flutter/material.dart';

class FlipController {
  VoidCallback? _flipCallback;

  void setFlipCallback(VoidCallback flipCallback) {
    _flipCallback = flipCallback;
  }

  void flip() {
    _flipCallback?.call();
  }
}