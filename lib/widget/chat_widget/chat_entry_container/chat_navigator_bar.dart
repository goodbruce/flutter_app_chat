import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/base_widget/button_widget.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_navigator_entry.dart';

// 底部导航条入口
class ChatNavigatorBar extends StatefulWidget {
  const ChatNavigatorBar({
    Key? key,
    required this.navigatorEntries,
    required this.onNavigatorItemPressed,
  }) : super(key: key);

  final List<CommNavigatorEntry> navigatorEntries;
  final Function(CommNavigatorEntry navigatorEntry) onNavigatorItemPressed;

  @override
  State<ChatNavigatorBar> createState() => _ChatNavigatorBarState();
}

class _ChatNavigatorBarState extends State<ChatNavigatorBar> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (widget.navigatorEntries.isEmpty) {
      return Container();
    }

    return Container(
      height: 44.0,
      width: screenSize.width,
      decoration: BoxDecoration(
        color: ColorUtil.hexColor(0xf7f7f7),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 10.0),
        child: Center(
          child: Row(
            children: buildNavigatorButtons(context),
          ),
        ),
      ),
    );
  }

  List<ChatNavigatorButton> buildNavigatorButtons(BuildContext context) {
    List<ChatNavigatorButton> navigatorButtons = [];

    navigatorButtons = widget.navigatorEntries
        .map(
          (CommNavigatorEntry entry) => ChatNavigatorButton(
            iconUrl: entry.icon ?? "",
            title: entry.name ?? "",
            onNavigatorItemPressed: () {
              widget.onNavigatorItemPressed(entry);
            },
          ),
        )
        .toList();

    return navigatorButtons;
  }
}

// 导航条的按钮
class ChatNavigatorButton extends StatelessWidget {
  const ChatNavigatorButton({
    Key? key,
    required this.iconUrl,
    required this.title,
    required this.onNavigatorItemPressed,
  }) : super(key: key);

  final String iconUrl;
  final String title;
  final Function onNavigatorItemPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      bgColor: ColorUtil.hexColor(0xffffff),
      bgHighlightedColor: ColorUtil.hexColor(0xf0f0f0),
      margin: const EdgeInsets.only(left: 10.0),
      height: 38.0,
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        bottom: 2.0,
        top: 2.0,
      ),
      borderRadius: 20.0,
      border: Border.all(
        color: ColorUtil.hexColor(0xf0f0f0),
        width: 1.0,
        style: BorderStyle.solid,
      ),
      onPressed: () {
        onNavigatorItemPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildIcon(context),
          const SizedBox(
            width: 5.0,
          ),
          buildContent(context),
        ],
      ),
    );
  }

  Widget buildIcon(BuildContext context) {
    // 本地图片
    return ImageHelper.imageNetwork(
      imageUrl: iconUrl,
      width: 18,
      height: 18,
    );
  }

  Widget buildContent(BuildContext context) {
    return Text(
      "${title}",
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: ColorUtil.hexColor(0x333333),
        decoration: TextDecoration.none,
      ),
    );
  }
}
