import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_chat/utils/color_util.dart';

class ConversationWidget extends StatefulWidget {
  const ConversationWidget({
    Key? key,
    this.title,
    this.content,
    this.contentColor,
    this.showArrow = false,
    required this.onPressed,
  }) : super(key: key);

  final String? title;
  final String? content;
  final Color? contentColor;
  final bool showArrow;
  final Function onPressed;

  @override
  State<ConversationWidget> createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget> {
  bool _highlighted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void onTouchDown() {
    setState(() {
      _highlighted = true;
    });
  }

  void onTouchCancel() {
    setState(() {
      _highlighted = false;
    });
  }

  void onTap() {
    onTouchDown();
    Future.delayed(Duration(milliseconds: 250), () {
      onTouchCancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
        widget.onPressed();
      },
      onTapDown: (TapDownDetails tapDownDetails) {
        onTouchDown();
      },
      onTapCancel: () {
        onTouchCancel();
      },
      onTapUp: (TapUpDetails tapUpDetails) {
        onTouchCancel();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        height: 50.0,
        decoration: BoxDecoration(
          color: _highlighted
              ? ColorUtil.hexColor(0xf0f0f0)
              : ColorUtil.hexColor(0xffffff),
          border: Border(
            bottom: BorderSide(
              color: ColorUtil.hexColor(0xf7f7f7),
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitle(),
            Expanded(
              child: _buildContent(),
            ),
            _buildArrowIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "${widget.title}",
      textAlign: TextAlign.left,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: ColorUtil.hexColor(0x333333),
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget _buildContent() {
    return Text(
      "${widget.content}",
      textAlign: TextAlign.right,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: widget.contentColor ?? ColorUtil.hexColor(0x333333),
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget _buildArrowIcon() {
    return widget.showArrow
        ? SizedBox(
      width: 20.0,
      child: Icon(
        Icons.arrow_forward_ios_outlined,
        color: ColorUtil.hexColor(0xbcbcbc),
        size: 15,
      ),
    )
        : SizedBox(
      width: 20.0,
    );
  }
}