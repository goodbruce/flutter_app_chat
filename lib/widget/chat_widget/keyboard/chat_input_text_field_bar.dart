import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/base_widget/button_widget.dart';
import 'package:flutter_app_chat/widget/chat_widget/keyboard/chat_input_bar_controller.dart';
import 'package:one_context/one_context.dart';

// 输入框
class ChatInputTextFieldBar extends StatefulWidget {
  const ChatInputTextFieldBar({
    Key? key,
    required this.onEmojiButtonPressed,
    required this.onMoreButtonPressed,
    required this.onInputFieldPressed,
    required this.chatInputBarController,
    required this.onInputOnEditingCompleted,
    required this.onPostButtonPressed,
    required this.onOutEmojiButtonPressed,
    required this.textEditingController,
    required this.inputOnSubmitted,
    required this.onOutMoreButtonPressed,
    required this.showPostEnterButton,
  }) : super(key: key);

  final Function onPostButtonPressed;
  final Function onOutEmojiButtonPressed;
  final Function onEmojiButtonPressed;
  final Function onMoreButtonPressed;
  final Function onOutMoreButtonPressed;
  final Function onInputFieldPressed;

  final Function(String text) inputOnSubmitted;
  final Function onInputOnEditingCompleted;
  final ChatInputBarController chatInputBarController;
  final TextEditingController textEditingController;
  final bool showPostEnterButton;

  @override
  State<ChatInputTextFieldBar> createState() => _ChatInputTextFieldBarState();
}

class _ChatInputTextFieldBarState extends State<ChatInputTextFieldBar> {
  // 默认
  ChatInputBarShowType inputBarShowType = ChatInputBarShowType.inputBarShowIdle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 更新状态
    widget.chatInputBarController.textFieldBarStatus =
        (ChatInputBarShowType showType) {
      inputBarShowType = showType;
      setState(() {});
    };
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorUtil.hexColor(0xf7f7f7),
        border: Border(
          bottom: BorderSide(width: 0.0, color: ColorUtil.hexColor(0xffffff)),
          left: BorderSide(width: 0.0, color: ColorUtil.hexColor(0xffffff)),
          right: BorderSide(width: 0.0, color: ColorUtil.hexColor(0xffffff)),
          top: BorderSide(width: 1, color: ColorUtil.hexColor(0xf0f0f0)),
        ),
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 5.0,
              top: 5.0,
              bottom: 5.0,
            ),
            child: widget.showPostEnterButton
                ? buildPostButton(context)
                : Container(),
          ),
          Expanded(
            child: ChatInputTextField(
              inputOnTap: () {
                widget.onInputFieldPressed();
              },
              inputOnChanged: (String string) {},
              inputOnSubmitted: (String string) {
                print("inputOnSubmitted");
                widget.inputOnSubmitted(string);
              },
              inputOnEditingCompleted: () {
                print("inputOnEditingCompleted");
                widget.onInputOnEditingCompleted();
              },
              chatInputBarController: widget.chatInputBarController,
              textEditingController: widget.textEditingController,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              top: 5.0,
              bottom: 5.0,
            ),
            child: buildEmojiButton(context),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 5.0,
              bottom: 5.0,
            ),
            child: buildMoreButton(context),
          ),
        ],
      ),
    );
  }

  Widget buildEmojiButton(BuildContext context) {
    return ButtonWidget(
      width: 32.0,
      height: 40.0,
      onPressed: () {
        if (ChatInputBarShowType.inputBarShowEmoji == inputBarShowType) {
          widget.onOutEmojiButtonPressed();
        } else {
          widget.onEmojiButtonPressed();
        }
      },
      child: buildEmojiIcon(context),
    );
  }

  Widget buildMoreButton(BuildContext context) {
    return ButtonWidget(
      width: 32.0,
      height: 40.0,
      onPressed: () {
        if (ChatInputBarShowType.inputBarShowMore == inputBarShowType) {
          widget.onOutMoreButtonPressed();
        } else {
          widget.onMoreButtonPressed();
        }
      },
      child: ImageHelper.wrapAssetAtImages(
        "icons/ic_tool_more.png",
        fit: BoxFit.cover,
        width: 30.0,
        height: 30.0,
      ),
    );
  }

  Widget buildPostButton(BuildContext context) {
    return ButtonWidget(
      width: 54.0,
      height: 40.0,
      onPressed: () {
        widget.onPostButtonPressed();
      },
      child: ImageHelper.wrapAssetAtImages(
        "icons/ic_tool_pubpost_blue.png",
        fit: BoxFit.cover,
        width: 54.0,
        height: 30.0,
      ),
    );
  }

  Widget buildEmojiIcon(BuildContext context) {
    if (ChatInputBarShowType.inputBarShowEmoji == inputBarShowType) {
      // 显示默认
      return ImageHelper.wrapAssetAtImages(
        "icons/ic_tool_keyboard.png",
        fit: BoxFit.cover,
        width: 30.0,
        height: 30.0,
      );
    }

    return ImageHelper.wrapAssetAtImages(
      "icons/ic_tool_emotion.png",
      fit: BoxFit.cover,
      width: 30.0,
      height: 30.0,
    );
  }
}

// 输入框
class ChatInputTextField extends StatefulWidget {
  const ChatInputTextField({
    Key? key,
    this.inputOnTap,
    this.inputOnChanged,
    this.inputOnSubmitted,
    this.inputOnEditingCompleted,
    this.autofocus = false,
    required this.chatInputBarController,
    required this.textEditingController,
  }) : super(key: key);

  final inputOnTap;
  final inputOnChanged;
  final inputOnSubmitted;
  final inputOnEditingCompleted;
  final bool autofocus;
  final ChatInputBarController chatInputBarController;
  final TextEditingController textEditingController;

  @override
  State<ChatInputTextField> createState() => _ChatInputTextFieldState();
}

class _ChatInputTextFieldState extends State<ChatInputTextField> {
  TextEditingController textEditingController = TextEditingController();

  FocusNode editFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    textEditingController.addListener(() {});

    // 定义焦点
    widget.chatInputBarController.inputFocusChanged = (bool isShouldFocus) {
      // 是否需要焦点
      print("inputFocusChanged isShouldFocus：${isShouldFocus}");
      if (isShouldFocus) {
        getFocusFunction(OneContext().context!);
      } else {
        unFocusFunction();
      }
    };
  }

  //获取焦点
  void getFocusFunction(BuildContext context) {
    FocusScope.of(context).requestFocus(editFocusNode);
  }

  //失去焦点
  void unFocusFunction() {
    editFocusNode.unfocus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    editFocusNode.unfocus();
    editFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        top: 5.0,
        bottom: 5.0,
      ),
      constraints: BoxConstraints(
        minHeight: 40.0,
        maxHeight: 120.0,
      ),
      child: TextField(
        onTap: () {
          widget.inputOnTap();
        },
        onChanged: (string) {
          widget.inputOnChanged(string);
        },
        onEditingComplete: () {
          widget.inputOnEditingCompleted();
        },
        onSubmitted: (string) {
          widget.inputOnSubmitted(string);
        },
        minLines: 1,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.center,
        autofocus: widget.autofocus,
        focusNode: editFocusNode,
        controller: widget.textEditingController,
        textInputAction: TextInputAction.send,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
          filled: true,
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: "说点什么吧～",
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: ColorUtil.hexColor(0xACACAC),
            decoration: TextDecoration.none,
          ),
          enabledBorder: OutlineInputBorder(
            /*边角*/
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0), //边角为30
            ),
            borderSide: BorderSide(
              color: ColorUtil.hexColor(0xf7f7f7), //边框颜色为绿色
              width: 1, //边线宽度为1
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0), //边角为30
            ),
            borderSide: BorderSide(
              color: ColorUtil.hexColor(0xECECEC), //边框颜色为绿色
              width: 1, //宽度为1
            ),
          ),
        ),
      ),
    );
  }
}
