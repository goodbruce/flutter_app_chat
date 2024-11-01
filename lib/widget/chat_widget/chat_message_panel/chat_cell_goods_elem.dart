import 'package:flutter/material.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_message.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';

// 商品
class ChatCellGoodsElem extends StatefulWidget {
  const ChatCellGoodsElem({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);

  final CommonChatMessage chatMessage;

  @override
  State<ChatCellGoodsElem> createState() => _ChatCellGoodsElemState();
}

class _ChatCellGoodsElemState extends State<ChatCellGoodsElem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      padding: EdgeInsets.all(10.0),
      child: buildLayout(context),
    );
  }

  Widget buildLayout(BuildContext context) {
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

  Widget buildImage(BuildContext context) {
    Size imageSize = Size(70, 70);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: ImageHelper.imageNetwork(
        imageUrl: "${widget.chatMessage.goodsImageUrl}",
        fit: BoxFit.cover,
        width: imageSize.width,
        height: imageSize.height,
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Text(
      "${widget.chatMessage.goodsTitle ?? ""}",
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
            text: "${widget.chatMessage.showGoodsPrice ?? ""}",
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
      "${widget.chatMessage.showGoodsOriginPrice ?? ""}",
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
}
