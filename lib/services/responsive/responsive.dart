import 'dart:ui';

import 'package:flutter/material.dart';

class Responsive {
  Responsive._();

  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 1024;

  static FlutterView _view(BuildContext context) =>
      View.of(context);

  static double width(BuildContext context) {
    final view = _view(context);
    return view.physicalSize.width / view.devicePixelRatio;
  }

  static double height(BuildContext context) {
    final view = _view(context);
    return view.physicalSize.height / view.devicePixelRatio;
  }

  static bool isMobile(BuildContext context) =>
      width(context) < mobileMaxWidth;

  static bool isTablet(BuildContext context) =>
      width(context) >= mobileMaxWidth &&
          width(context) < tabletMaxWidth;

  static bool isDesktop(BuildContext context) =>
      width(context) >= tabletMaxWidth;
}
