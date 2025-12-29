import 'package:flutter/material.dart';

class Rs {
  static const double baseFigmaHeight = 970;
  static const double baseFigmaWidth = 454;
  static double? designDevicePixelRatio;
  static double? deviceHeight;
  static double? deviceWidth;
}

double v(double height, BuildContext context) {
  final mediaQuery = MediaQuery.sizeOf(context);
  final dpr = MediaQuery.devicePixelRatioOf(context);
  // MediaQuery.of(context);
  // debugprint(
  //     "${MediaQuery.of(context).size.height}---------${mediaQuery.height}");
  // debugprint(
  //     "${MediaQuery.of(context).size.width}---------${mediaQuery.width}");
  // debugmagenta(MediaQuery.of(context).devicePixelRatio);
  // Rs.designDevicePixelRatio = mediaQuery.devicePixelRatio;

  Rs.designDevicePixelRatio = dpr;
  // final physicalHeight = mediaQuery.size.height * mediaQuery.devicePixelRatio;
  final physicalHeight = mediaQuery.height * Rs.designDevicePixelRatio!;
  Rs.deviceHeight = physicalHeight;
  // debugorange("physical Height ======== $physicalHeight");
  final basePhysicalHeight = Rs.baseFigmaHeight * Rs.designDevicePixelRatio!;
  // debugwhite("base physical height ====$basePhysicalHeight");
  // debugblue(physicalHeight / basePhysicalHeight);
  return height * (physicalHeight / basePhysicalHeight)
  // /
  // MediaQuery.of(context).devicePixelRatio
  ;
}

double h(double width, BuildContext context) {
  // final mediaQuery = MediaQuery.of(context);
  final mediaQuery = MediaQuery.sizeOf(context);
  final dpr = MediaQuery.devicePixelRatioOf(context);
  // Rs.designDevicePixelRatio = mediaQuery.devicePixelRatio;
  Rs.designDevicePixelRatio = dpr;
  // final physicalWidth = mediaQuery.size.width * mediaQuery.devicePixelRatio;
  final physicalWidth = mediaQuery.width * Rs.designDevicePixelRatio!;
  Rs.deviceWidth = physicalWidth;
  final basePhysicalWidth = Rs.baseFigmaWidth * Rs.designDevicePixelRatio!;
  return width * (physicalWidth / basePhysicalWidth)
  // /
  // MediaQuery.of(context).devicePixelRatio
  ;
}
