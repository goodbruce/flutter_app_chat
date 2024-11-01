import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/base_widget/button_widget.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_vistor_statistics.dart';

// 数据统计入口
class ChatStatisticsBar extends StatefulWidget {
  const ChatStatisticsBar({
    Key? key,
    required this.visitorStatistics,
    required this.onStatisticsBarPressed,
  }) : super(key: key);

  final CommVisitorStatistics visitorStatistics;
  final Function onStatisticsBarPressed;

  @override
  State<ChatStatisticsBar> createState() => _ChatStatisticsBarState();
}

class _ChatStatisticsBarState extends State<ChatStatisticsBar> {
  @override
  Widget build(BuildContext context) {
    int rowNumber = 3;
    Size screenSize = MediaQuery.of(context).size;
    double itemWidth = screenSize.width / rowNumber;
    double showHeight = 40.0;
    return ButtonWidget(
      bgColor: ColorUtil.hexColor(0xffffff),
      bgHighlightedColor: ColorUtil.hexColor(0xf0f0f0),
      height: showHeight,
      width: double.infinity,
      onPressed: () {
        widget.onStatisticsBarPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ChatStatisticsItem(
            width: itemWidth,
            height: showHeight,
            iconFile: "file://ic_tool_visitor.png",
            title: "访客量",
            number: "${widget.visitorStatistics.accessUCount ?? 0}",
          ),
          ChatStatisticsItem(
            width: itemWidth,
            height: showHeight,
            iconFile: "file://ic_tool_liulanl.png",
            title: "浏览量",
            number: "${widget.visitorStatistics.accessCount ?? 0}",
          ),
          ChatStatisticsItem(
            width: itemWidth,
            height: showHeight,
            iconFile: "file://ic_show_people.png",
            title: "当前人数",
            number: "${widget.visitorStatistics.onlineUserCount ?? 0}",
          )
        ],
      ),
    );
  }
}

// 单个item
class ChatStatisticsItem extends StatelessWidget {
  const ChatStatisticsItem({
    Key? key,
    required this.width,
    required this.height,
    required this.iconFile,
    required this.title,
    required this.number,
  }) : super(key: key);

  final double width;
  final double height;
  final String iconFile;
  final String title;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildIcon(context),
          SizedBox(
            width: 5.0,
          ),
          buildContent(context),
        ],
      ),
    );
  }

  Widget buildIcon(BuildContext context) {
    // 本地图片
    String imageUrl = "${iconFile ?? ""}";
    String start = "file://";
    if (imageUrl.startsWith(start)) {
      String imageAssetFile = imageUrl.substring(start.length);

      return ImageHelper.wrapAssetAtImages(
        "icons/${imageAssetFile}",
        width: 18.0,
        height: 18.0,
      );
    }

    return Container();
  }

  Widget buildContent(BuildContext context) {
    return Text(
      "${title} ${number}",
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
