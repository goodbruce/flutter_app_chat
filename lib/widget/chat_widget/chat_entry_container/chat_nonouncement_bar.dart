import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/base_widget/button_widget.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_announcement_notice.dart';

// 公告入口Bar
class ChatAnnouncementBar extends StatefulWidget {
  const ChatAnnouncementBar({
    Key? key,
    required this.announcementNotice,
    required this.onAnnouncementPressed,
  }) : super(key: key);

  final CommAnnouncementNotice announcementNotice;
  final Function onAnnouncementPressed;

  @override
  State<ChatAnnouncementBar> createState() => _ChatAnnouncementBarState();
}

class _ChatAnnouncementBarState extends State<ChatAnnouncementBar> {
  @override
  Widget build(BuildContext context) {
    if (widget.announcementNotice.showGroupNotice == false) {
      return Container();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: ColorUtil.hexColor(0xffffff),
        borderRadius: const BorderRadius.all(
          Radius.circular(6.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: buildContent(context),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Container(
              height: 20,
              width: 1.0,
              color: ColorUtil.hexColor(0xe0e0e0),
            ),
          ),
          buildLookButton(context),
        ],
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return Text(
      widget.announcementNotice.content ?? "",
      textAlign: TextAlign.left,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: ColorUtil.hexColor(0x333333),
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget buildLookButton(BuildContext context) {
    return ButtonWidget(
      height: 36.0,
      width: 60.0,
      bgHighlightedColor: ColorUtil.hexColor(0xf0f0f0),
      onPressed: () {
        widget.onAnnouncementPressed();
      },
      child: Text(
        "点击查看",
        textAlign: TextAlign.left,
        maxLines: 1,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          color: ColorUtil.hexColor(0x3b93ff),
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
