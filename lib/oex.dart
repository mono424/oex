library oex;

export 'package:oex/models/OEXEngine.dart';

import 'package:flutter/services.dart';
import 'dart:async';
import 'package:oex/models/OEXEngine.dart';

class OEX {
  static const platformMethodChannel = const MethodChannel('khad.im.oex');

  static Future<List<OEXEngine>> search() async {
    try {
      List<OEXEngine> list = [];
      final List<dynamic> result = await platformMethodChannel.invokeMethod('search');
      for (List<dynamic> entry in result) {
        list.add(OEXEngine(
          entry[0],
          entry[1],
          int.parse(entry[2]),
          entry[3],
          entry[4],
        ));
      }
      return list;
    } on PlatformException catch (e) {
      print(e);
      return [];
    }
  }

}