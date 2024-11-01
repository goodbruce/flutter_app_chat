import 'package:flutter/material.dart';
import 'package:flutter_app_chat/widget/base_widget/button_widget.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/chat_cell_image_elem.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_message.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';

class ChatCellPosterElem extends StatefulWidget {
  const ChatCellPosterElem({
    Key? key,
    required this.chatMessage,
    required this.onFeedLikePressed,
    required this.onFeedCommentPressed,
  }) : super(key: key);

  final CommonChatMessage chatMessage;
  final Function(CommonChatMessage chatMessage) onFeedLikePressed;
  final Function(CommonChatMessage chatMessage) onFeedCommentPressed;

  @override
  State<ChatCellPosterElem> createState() => _ChatCellPosterElemState();
}

class _ChatCellPosterElemState extends State<ChatCellPosterElem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      padding: EdgeInsets.all(10.0),
      child: buildPostLayout(context),
    );
  }

  Widget buildPostLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildPostTitle(context),
        SizedBox(
          height: 7.0,
        ),
        buildPostImage(context),
        SizedBox(
          height: 7.0,
        ),
        buildPostTooBar(context),
      ],
    );
  }

  Widget buildPostTitle(BuildContext context) {
    return Text(
      "${widget.chatMessage.postContent ?? ""}",
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: ColorUtil.hexColor(0x333333),
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget buildPostImage(BuildContext context) {
    List<CommonChatMessagePosterImage>? postImages =
        widget.chatMessage.postImages;
    double maxWidth = 230.0;
    double separate = 5.0;
    if (postImages != null && postImages.isNotEmpty) {
      if (postImages.length == 1) {
        // 只有一张图
        CommonChatMessagePosterImage posterImage = postImages[0];
        return buildImage(
          context,
          imageSize: posterImage.imageSize ?? Size.zero,
          imageUrl: posterImage.imageUrl ?? "",
        );
      } else {
        int imageCount = postImages.length;

        int colNum = 3;
        double perImageW;
        if (imageCount == 2 || imageCount == 4) {
          colNum = 2;
        }
        perImageW = (maxWidth - colNum * separate) / colNum;
        double perImageH = perImageW;

        List<Widget> postImageWidgets = [];
        for (CommonChatMessagePosterImage posterImage in postImages) {
          Widget imageWidget = ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            child: ImageHelper.imageNetwork(
              imageUrl: "${posterImage.imageUrl ?? ""}",
              fit: BoxFit.cover,
              width: perImageW,
              height: perImageH,
            ),
          );
          postImageWidgets.add(imageWidget);
        }

        return Wrap(
          spacing: separate, // 主轴(水平)方向间距
          runSpacing: separate, // 纵轴（垂直）方向间距
          alignment: WrapAlignment.start, //沿主轴方向居中
          children: postImageWidgets,
        );
      }
    }

    return Container();
  }

  Widget buildImage(
    BuildContext context, {
    required Size imageSize,
    required String imageUrl,
  }) {
    double maxWidth = 240.0;
    double maxHeight = 500.0;
    imageSize = ChatCellImageLayout.showPreImageSize(
        imageSize ?? Size.zero, maxWidth, maxHeight);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      child: ImageHelper.imageNetwork(
        imageUrl: "${imageUrl}",
        fit: BoxFit.cover,
        width: imageSize.width,
        height: imageSize.height,
      ),
    );
  }

  Widget buildPostTooBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildLikeButton(context),
        SizedBox(
          width: 15.0,
        ),
        buildCommentButton(context),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }

  Widget buildLikeButton(BuildContext context) {
    return ButtonWidget(
      height: 32.0,
      padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
      onPressed: () {
        widget.onFeedLikePressed(widget.chatMessage);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageHelper.wrapAssetAtImages(
            "icons/ic_post_unlike.png",
            fit: BoxFit.fill,
            width: 16.0,
            height: 13.0,
          ),
          SizedBox(
            width: 3.0,
          ),
          Text(
            "${widget.chatMessage.showLikeNum ?? ""}",
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              color: ColorUtil.hexColor(0x555555),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
      bgColor: ColorUtil.hexColor(0xffffff),
      bgHighlightedColor: ColorUtil.hexColor(0xf0f0f0),
      enabled: true,
    );
  }

  Widget buildCommentButton(BuildContext context) {
    return ButtonWidget(
      padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
      height: 32.0,
      onPressed: () {
        widget.onFeedCommentPressed(widget.chatMessage);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageHelper.wrapAssetAtImages(
            "icons/ic_post_comment.png",
            fit: BoxFit.fill,
            width: 16.0,
            height: 13.0,
          ),
          SizedBox(
            width: 3.0,
          ),
          Text(
            "${widget.chatMessage.showLikeNum ?? ""}",
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              color: ColorUtil.hexColor(0x555555),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
      bgColor: ColorUtil.hexColor(0xffffff),
      bgHighlightedColor: ColorUtil.hexColor(0xf0f0f0),
      enabled: true,
    );
  }
}
