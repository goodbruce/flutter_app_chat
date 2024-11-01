import 'package:flutter/material.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_message.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';

// 拼团
class ChatCellBuyTogetherElem extends StatefulWidget {
  const ChatCellBuyTogetherElem({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);

  final CommonChatMessage chatMessage;

  @override
  State<ChatCellBuyTogetherElem> createState() =>
      _ChatCellBuyTogetherElemState();
}

class _ChatCellBuyTogetherElemState extends State<ChatCellBuyTogetherElem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      padding: EdgeInsets.all(10.0),
      child: buildLayout(context),
    );
  }

  Widget buildLayout(BuildContext context) {
    return Container(
        height: 110.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildPtGoodsInfoLayout(context),
            buildPtBGLayout(context),
          ],
        ));
  }

  Widget buildImage(BuildContext context) {
    Size imageSize = Size(70, 70);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: ImageHelper.imageNetwork(
        imageUrl: "${widget.chatMessage.ptGoodsImageUrl}",
        fit: BoxFit.cover,
        width: imageSize.width,
        height: imageSize.height,
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Text(
      "${widget.chatMessage.ptGoodsTitle ?? ""}",
      textAlign: TextAlign.left,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: ColorUtil.hexColor(0x333333),
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget buildPrice(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "¥",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              color: ColorUtil.hexColor(0xFF2c69),
              decoration: TextDecoration.none,
            ),
          ),
          TextSpan(
            text: "${widget.chatMessage.ptGoodsCurrentPrice ?? ""}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              color: ColorUtil.hexColor(0xFF2c69),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildOriginPrice(BuildContext context) {
    return Text(
      "${widget.chatMessage.ptGoodsOriginPrice ?? ""}",
      textAlign: TextAlign.left,
      maxLines: 1,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: ColorUtil.hexColor(0xAAAAAA),
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget buildPtGoodsInfoLayout(BuildContext context) {
    return Container(
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImage(context),
          SizedBox(
            width: 7.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: buildTitle(context),
                ),
                buildPrice(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPtBGLayout(BuildContext context) {
    return Container(
      height: 30.0,
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.0, color: ColorUtil.hexColor(0xffffff)),
          left: BorderSide(width: 0.0, color: ColorUtil.hexColor(0xffffff)),
          right: BorderSide(width: 0.0, color: ColorUtil.hexColor(0xffffff)),
          top: BorderSide(width: 1.0, color: ColorUtil.hexColor(0xf0f0f0)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageHelper.wrapAssetAtImages(
            "icons/ic_pintuan.png",
            fit: BoxFit.cover,
            width: 20.0,
            height: 23.0,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            "拼团",
            textAlign: TextAlign.left,
            maxLines: 1,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              color: ColorUtil.hexColor(0xAAAAAA),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
