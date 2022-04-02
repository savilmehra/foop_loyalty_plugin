
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';



class LoyaltyFoop {
  static const MethodChannel _channel = MethodChannel('loyalty_foop');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
