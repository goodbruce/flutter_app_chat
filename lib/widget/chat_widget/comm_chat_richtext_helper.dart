import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_emoji.dart';

// 富文本
class CommChatRichTextHelper {
  //图文混排
  static getRichText(String text) {
    List<InlineSpan> textSapns = [];

    String urlExpString =
        r"(http|ftp|https)://([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?";
    String emojExpString = r"\[.{1,4}?\]";
    RegExp exp = RegExp('$urlExpString|$emojExpString');

    //正则表达式是否在字符串[input]中有匹配。
    if (exp.hasMatch(text)) {
      Iterable<RegExpMatch> matches = exp.allMatches(text);

      int index = 0;
      int count = 0;
      for (var matche in matches) {
        count++;
        String c = text.substring(matche.start, matche.end);
        //匹配到的东西,如表情在首位
        if (index == matche.start) {
          index = matche.end;
        }
        //匹配到的东西,如表情不在首位
        else if (index < matche.start) {
          String leftStr = text.substring(index, matche.start);
          index = matche.end;
          textSapns.add(
            TextSpan(
              text: spaceWord(leftStr),
              style: getDefaultTextStyle(),
            ),
          );
        }

        //匹配到的网址
        if (RegExp(urlExpString).hasMatch(c)) {
          textSapns.add(
            TextSpan(
              text: spaceWord(c),
              style:
                  TextStyle(color: ColorUtil.hexColor(0x3b93ff), fontSize: 16),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  //打开浏览器
                  print(c);
                },
            ),
          );
        }
        //匹配到的表情
        else if (RegExp(emojExpString).hasMatch(c)) {
          //[偷笑] 去掉[] = 偷笑
          String emojiString = c;
          textSapns.add(
            WidgetSpan(
              style: const TextStyle(height: 1.5),
              //判断表情是否存在
              child: CommonChatEmoji.emojiIsContain(emojiString)
                  ? ImageHelper.imageNetwork(
                      imageUrl:
                          "${CommonChatEmoji.findEmojiItem(emojiString)?.url}",
                      width: 22,
                      height: 22,
                    )
                  : Text(
                      "${c}",
                      style: getDefaultTextStyle(),
                    ),
            ),
          );
        }

        //是否是最后一个表情,并且后面是否有字符串
        if (matches.length == count && text.length > index) {
          String rightStr = text.substring(index, text.length);
          textSapns.add(
            TextSpan(
              text: spaceWord(rightStr),
              style: getDefaultTextStyle(),
            ),
          );
        }
      }
    } else {
      textSapns.add(
        TextSpan(
          text: spaceWord(text),
          style: getDefaultTextStyle(),
        ),
      );
    }

    return Text.rich(TextSpan(children: textSapns));
  }

  static TextStyle getDefaultTextStyle() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: ColorUtil.hexColor(0x555555),
      decoration: TextDecoration.none,
    );
  }

  static String spaceWord(String text) {
    if (text.isEmpty) return text;
    String spaceWord = '';
    for (var element in text.runes) {
      spaceWord += String.fromCharCode(element);
      spaceWord += '\u200B';
    }
    return spaceWord;
  }
}
