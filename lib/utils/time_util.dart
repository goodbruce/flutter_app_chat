import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

class TimeUtil {
  static String getCurrentPosition(int seconds) {
    String hours = '00';
    int timeHours = (seconds / (60 * 60)).toInt();
    int timeMinutes = (seconds / 60).toInt() - (timeHours * 60);
    int timeSeconds = seconds - (timeHours * 60 * 60) - (timeMinutes * 60);

    if (timeHours > 9) {
      hours = '$timeHours';
    } else if (timeHours > 0 && timeHours < 10) {
      hours = '0${timeHours}';
    } else {
      hours = '00';
    }
    String minutes = '00';
    if (timeMinutes > 9) {
      minutes = '${timeMinutes}';
    } else if (timeMinutes > 0 && timeMinutes < 10) {
      minutes = '0${timeMinutes}';
    } else {
      minutes = '00';
    }
    String second = '00';
    if (timeSeconds > 9) {
      second = '${timeSeconds}';
    } else if (timeSeconds > 0 && timeSeconds < 10) {
      second = '0${timeSeconds}';
    } else {
      second = '00';
    }
    return '${hours}:${minutes}:${second}';
  }

  static String timeFormatterChatTimeStamp(int seconds) {
    try {
      int nowDateSeconds =
          (DateTime.now().millisecondsSinceEpoch / 1000).truncate();

      String anotherDate =
          DateUtil.formatDateMs(seconds*1000, format: DateFormats.full);

      String nowDate =
          DateUtil.formatDateMs(nowDateSeconds*1000, format: DateFormats.full);

      print(
          "timeFormatterChatTimeStamp "
              "seconds:${seconds},"
              "nowDateSeconds:${nowDateSeconds},"
              "anotherDate:${anotherDate},"
              "nowDate:${nowDate}");
      //为了判断当前时间是否为未来时间
      if (seconds > nowDateSeconds) {
        return anotherDate;
      }

      List<String> anotherDateList = anotherDate.split(" ");
      List<String> nowDateList = nowDate.split(" ");
      if (anotherDateList.length == 2 && nowDateList.length == 2) {
        String nowDateYMD = nowDateList[0];
        String nowDateHMS = nowDateList[1];

        String anotherDateYMD = anotherDateList[0];
        String anotherDateHMS = anotherDateList[1];

        List<String> anotherDateYMDList = anotherDateYMD.split("-");
        List<String> nowDateYMDList = nowDateYMD.split("-");

        List<String> anotherDateHMSList = anotherDateHMS.split(":");
        List<String> nowDateHMSList = nowDateHMS.split(":");

        String anotherDateY = anotherDateYMDList[0];
        String anotherDateM = anotherDateYMDList[1];
        String anotherDateD = anotherDateYMDList[2];

        String nowDateY = nowDateYMDList[0];
        String nowDateM = nowDateYMDList[1];
        String nowDateD = nowDateYMDList[2];

        String anotherDateH = anotherDateHMSList[0];
        String anotherDateMi = anotherDateHMSList[1];
        String anotherDateS = anotherDateHMSList[2];

        int year = int.parse(anotherDateY) - int.parse(nowDateY);
        if (year < 0) {
          // 过去（今年以前）
          return "${anotherDateY}年${anotherDateM}月${anotherDateD}日 ${anotherDateH}:${anotherDateMi}";
        } else {
          if (nowDateY == anotherDateY) {
            // 今年
            return "${anotherDateM}月${anotherDateD}日 ${anotherDateH}:${anotherDateMi}";
          } else {
            return "${anotherDateY}年${anotherDateM}月${anotherDateD}日 ${anotherDateH}:${anotherDateMi}";
          }
        }
      } else {
        return anotherDate;
      }
    } catch (e) {
      return "${seconds}";
    }
  }

  static double getProgress(int seconds, int duration) {
    return seconds / duration;
  }
}
