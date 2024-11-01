
import 'dart:ui';

class ColorUtil {
  /// 十六进制颜色，
  /// hex, 十六进制值，例如：0xffffff,
  /// alpha, 透明度 [0.0,1.0]
  static Color hexColor(int hex,{double alpha = 1}){
    if (alpha < 0){
      alpha = 0;
    }else if (alpha > 1){
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16 ,
        (hex & 0x00FF00) >> 8,
        (hex & 0x0000FF) >> 0,
        alpha);
  }

  /// 十六进制颜色字符串，
  /// hex, 十六进制值，例如：0xffffff,
  /// alpha, 透明度 [0.0,1.0]
  static Color hexColorString(String hexColor) {
    Color color = Color(ColorUtil.getColorFromHex(hexColor));
    return color;
  }

  static int getColorFromHex(String hexColor) {
    if (hexColor.startsWith("#")) {
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
    } else {
      hexColor = hexColor.toUpperCase();
    }
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  /// 颜色检测只保存 #RRGGBB格式 FF透明度
  /// [color] 格式可能是材料风/十六进制/string字符串
  /// 返回[String] #rrggbb 字符串
  static String? color2HEX(Color color) {
    // 0xFFFFFFFF
    //将十进制转换成为16进制 返回字符串但是没有0x开头
    String temp = color.value.toRadixString(16);
    if (temp.isNotEmpty) {
      print("color2HEX temp：${temp}");
      if (temp.length == 8) {
        String hexColor = "#" + temp.substring(2, 8);
        return hexColor.toLowerCase();
      } else {
        String hexColor = "#" + temp;
        return hexColor.toLowerCase();
      }
    }

    return null;
  }
}