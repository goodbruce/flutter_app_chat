import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_message.dart';

// 音频
class ChatCellAudioElem extends StatefulWidget {
  const ChatCellAudioElem({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);

  final CommonChatMessage chatMessage;

  @override
  State<ChatCellAudioElem> createState() => _ChatCellAudioElemState();
}

class _ChatCellAudioElemState extends State<ChatCellAudioElem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: buildAudioLayout(context),
    );
  }

  Widget buildAudioLayout(BuildContext context) {
    double maxWidth = 200.0;

    String? duration = widget.chatMessage.duration;
    double containWidth = 0.0;
    if (duration != null && duration.isNotEmpty) {
      containWidth = maxWidth * (double.parse(duration) / 60.0);
    }
    if (CommMessageFromType.commMessageFromTypeOutgoing ==
        widget.chatMessage.messageFromType) {
      return Container(
        width: containWidth + 60.0,
        height: 30.0,
        child: Stack(
          children: [
            buildSendAudio(context),
            Positioned(
              top: 0.0,
              left: 3.0,
              child: buildHasPlayFlag(context),
            ),
          ],
        ),
      );
    }

    if (CommMessageFromType.commMessageFromTypeReceiving ==
        widget.chatMessage.messageFromType) {
      return Container(
        width: containWidth + 60.0,
        height: 30.0,
        child: Stack(
          children: [
            buildReceiveAudio(context),
            Positioned(
              top: 0.0,
              right: 3.0,
              child: buildHasPlayFlag(context),
            ),
          ],
        ),
      );
    }

    return Container();
  }

  Widget buildReceiveAudio(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildAudioPlayIcon(context),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "${widget.chatMessage.duration}'s",
              textAlign: TextAlign.right,
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
          ),
        ),
      ],
    );
  }

  Widget buildSendAudio(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "${widget.chatMessage.duration}'s",
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
          ),
        ),
        buildAudioPlayIcon(context),
      ],
    );
  }

  Widget buildAudioPlayIcon(BuildContext context) {
    if (CommMessageFromType.commMessageFromTypeOutgoing ==
        widget.chatMessage.messageFromType) {
      return ImageHelper.wrapAssetAtImages(
        "icons/icon_sender_voice_playing.png",
        width: 30.0,
        height: 30.0,
      );
    }

    if (CommMessageFromType.commMessageFromTypeReceiving ==
        widget.chatMessage.messageFromType) {
      return ImageHelper.wrapAssetAtImages(
        "icons/icon_receiver_voice_playing.png",
        width: 30.0,
        height: 30.0,
      );
    }

    return Container();
  }

  Widget buildHasPlayFlag(BuildContext context) {
    bool isPlayed = widget.chatMessage.hasPlayed;
    if (isPlayed) {
      return Container();
    }

    return Container(
      width: 6.0,
      height: 6.0,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
