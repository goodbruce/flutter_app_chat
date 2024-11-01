import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class StringUtils {
  static String? toMD5(String data) {
    if (data == null) {
      return null;
    }
    return md5.convert(utf8.encode(data)).toString();
  }

  // static String? urlDecoder(String data) {
  //   return HtmlUnescape().convert(data);
  // }

  static String getRandom(int length) {
    if (length <= 0) {
      return "";
    }

    String sourceStr = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String lengthString = "";
    for (int i = 0; i < length; i++) {
      int index = Random().nextInt(sourceStr.length);
      String oneStr = sourceStr.substring(index, index + 1);
      lengthString = "${lengthString}${oneStr}";
    }
    return lengthString.toLowerCase();
  }

  static String removeHtmlLabel(String data) {
    return data.replaceAll(RegExp('<[^>]+>'), '');
  }
}
