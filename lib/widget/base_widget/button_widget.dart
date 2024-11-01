import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//枚举类的声明
enum ButtonAlignment { Center, Left, Right }

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    Key? key,
    this.bgColor,
    this.bgHighlightedColor,
    this.color,
    this.highlightedColor,
    this.disableColor,
    this.bgDisableColor,
    this.width,
    this.height,
    this.borderRadius,
    this.buttonAlignment: ButtonAlignment.Center,
    this.text: "",
    this.textFontSize,
    this.icon,
    this.iconTextPadding,
    required this.onPressed,
    this.enabled = true,
    required this.child,
    this.border,
    this.padding,
    this.margin,
    this.onLongPressStart,
    this.onLongPressCancel,
  }) : super(key: key);

  final Color? bgColor; // 背景颜色
  final Color? bgHighlightedColor; // 背景点击高亮颜色
  final Color? color;
  final Color? highlightedColor;
  final Color? disableColor;
  final Color? bgDisableColor;
  final double? width;
  final double? height;
  final VoidCallback onPressed;
  final double? borderRadius;
  final ButtonAlignment? buttonAlignment;
  final String? text;
  final double? textFontSize;
  final Icon? icon;
  final double? iconTextPadding;
  final bool? enabled;
  final Widget child;
  final Border? border;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressCancelCallback? onLongPressCancel;

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool _highlighted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _highlighted = false;
  }

  void handleTapDown(TapDownDetails details) {
    if (widget.enabled != null && widget.enabled == true) {
      setState(() {
        _highlighted = true;
      });
    }
  }

  void handleTapUp(TapUpDetails details) {
    setState(() {
      _highlighted = false;
    });
  }

  void handleTapCancel() {
    setState(() {
      _highlighted = false;
    });
  }

  void handleTap() {
    print("handleTap");
    if (widget.enabled != null && widget.enabled == true) {
      setState(() {
        _highlighted = true;
      });
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          _highlighted = false;
        });
      });

      if (widget.enabled != null && widget.enabled == true) {
        widget.onPressed();
      }
    }
  }

  AlignmentGeometry showAlignment(ButtonAlignment? buttonAlignment) {
    AlignmentGeometry alignment = Alignment.center;
    if (buttonAlignment != null) {
      if (buttonAlignment == ButtonAlignment.Left) {
        alignment = Alignment.centerLeft;
      } else if (buttonAlignment == ButtonAlignment.Right) {
        alignment = Alignment.centerRight;
      } else {
        alignment = Alignment.center;
      }
    }

    return alignment;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: widget.onLongPressStart,
      onLongPressCancel: widget.onLongPressCancel,
      onTapDown: handleTapDown,
      // 处理按下事件
      onTapUp: handleTapUp,
      // 处理抬起事件
      onTap: handleTap,
      onTapCancel: handleTapCancel,
      child: Container(
        margin: widget.margin,
        padding: widget.padding,
        width: widget.width,
        height: widget.height,
        alignment: showAlignment(widget.buttonAlignment),
        decoration: BoxDecoration(
            color: boxDecorationBgColor(),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
            border: widget.border),
        child: widget.child,
      ),
    );
  }

  Color? boxDecorationBgColor() {
    if (widget.enabled != null && widget.enabled == true) {
      return (_highlighted ? widget.bgHighlightedColor : widget.bgColor);
    }

    return widget.bgDisableColor ?? widget.bgColor;
  }

  Color? textColor() {
    if (widget.enabled != null && widget.enabled == true) {
      return (_highlighted ? widget.highlightedColor : widget.color);
    }

    return widget.disableColor ?? widget.bgColor;
  }
}
