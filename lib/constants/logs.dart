// import 'dart:developer' show log;
// import 'package:flutter/foundation.dart' show kDebugMode;

import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter());
var loggerNoStack = Logger(printer: PrettyPrinter(methodCount: 0));

// void demo() {
//   logger.d('Log message with 2 methods');
//   loggerNoStack.i('Info message');
//   loggerNoStack.w('Just a warning!');
//   logger.e('Error! Something bad happened', error: 'Test Error');
//   loggerNoStack.t({'key': 5, 'value': 'something'});
//   Logger(printer: SimplePrinter(colors: true)).t('boom');
// }

// Function o = ([dynamic message = ""]) {
//   if (kDebugMode) {
//     log('\x1B[38;5;208m${message.toString()}\x1B[0m');
//   }
// };

// class Print {
//   static b([dynamic e = ""]) {
//     if (kDebugMode) {
//       log('\x1B[34m${e.toString()}\x1B[0m');
//     }
//   }

//   static g([dynamic message = ""]) {
//     if (kDebugMode) {
//       // debugPrint(messagage, wrapWidth: 50);
//       log('\x1B[32m${message.toString()}\x1B[0m');
//     }
//   }

//   static r([dynamic message = ""]) {
//     if (kDebugMode) {
//       log('\x1B[31m${message.toString()}\x1B[0m');
//     }
//   }

//   static y([dynamic message = ""]) {
//     if (kDebugMode) {
//       log('\x1B[33m${message.toString()}\x1B[0m');
//     }
//   }

//   static w([dynamic message = ""]) {
//     if (kDebugMode) {
//       log('\x1B[37m${message.toString()}\x1B[0m');
//     }
//   }

//   static m([dynamic message = ""]) {
//     if (kDebugMode) {
//       log('\x1B[35m${message.toString()}\x1B[0m');
//     }
//   }

//   static c([dynamic message = ""]) {
//     if (kDebugMode) {
//       log('\x1B[36m${message.toString()}\x1B[36m');
//     }
//   }

//   static o([dynamic message = ""]) {
//     if (kDebugMode) {
//       log('\x1B[38;5;208m${message.toString()}\x1B[0m');
//     }
//   }
// }
