import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'
    show ModalProgressHUD;

import 'responsive.dart' as res;

extension DesignExtension on num {
  double v(BuildContext context) => res.v(toDouble(), context);
  double h(BuildContext context) => res.h(toDouble(), context);
}

extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension StringComparison on String {
  bool ignoreEquals(String comparingString) {
    return toLowerCase() == comparingString.toLowerCase();
  }
}

extension Indicator on Widget {
  ModalProgressHUD modalProgressHud(bool inAsyncCall) {
    return ModalProgressHUD(
      color: Colors.transparent,
      blur: 2.0,
      inAsyncCall: inAsyncCall,
      progressIndicator: const CircularProgressIndicator.adaptive(),
      child: this,
    );
  }
}

extension PaddingExtension on Widget {
  Padding padLeft([double? value]) {
    return Padding(
      padding: EdgeInsets.only(left: value ?? 0),
      child: this,
    );
  }

  Padding padRight([double? value]) {
    return Padding(
      padding: EdgeInsets.only(right: value ?? 0),
      child: this,
    );
  }

  Padding padTop([double? value]) {
    return Padding(
      padding: EdgeInsets.only(top: value ?? 0),
      child: this,
    );
  }

  Padding padBottom([double? value]) {
    return Padding(
      padding: EdgeInsets.only(bottom: value ?? 0),
      child: this,
    );
  }

  Padding padVertical([double? value]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: value ?? 0),
      child: this,
    );
  }

  Padding padHorizontal([double? value]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value ?? 0),
      child: this,
    );
  }

  Padding padAll([double? value]) {
    return Padding(padding: EdgeInsets.all(value ?? 0), child: this);
  }

  // Container decorationContainer(BuildContext context) {
  //   return Container(
  //     height: v(22, context),
  //     width: h(42, context),
  //     padding: EdgeInsets.symmetric(
  //         vertical: v(1, context), horizontal: h(2, context)),
  //     decoration: BoxDecoration(
  //         color: TextColors.white,
  //         borderRadius: BorderRadius.circular(20),
  //         boxShadow: [
  //           BoxShadow(
  //               blurRadius: 10,
  //               spreadRadius: 0,
  //               offset: const Offset(3, 3),
  //               color: TextColors.checkInBpShadow.withOpacity(0.2)),
  //         ]
  //         // border:
  //         //     Border.all(color: item.iconBackground!)
  //         ),
  //     child: this,
  //   );
  // }
}

// extension MyShadow on BoxDecoration {
//   BoxDecoration boxDecor() {
//     return BoxDecoration(color: TextColors.white, boxShadow: [
//       BoxShadow(
//           blurRadius: 10,
//           spreadRadius: 0,
//           offset: const Offset(3, 3),
//           color: TextColors.checkInBpShadow.withOpacity(0.2)),
//     ]);
//   }
// }
