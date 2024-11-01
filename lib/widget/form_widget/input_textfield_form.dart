import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/widget/base_widget/button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputTextFieldForm extends StatefulWidget {
  const InputTextFieldForm({
    Key? key,
    required this.editingController,
    required this.focusNode,
    required this.size,
    this.prefixIcon,
    this.hintText,
    this.labelText,
    this.labelStyle,
    this.style,
    this.hintStyle,
    this.focusedBorderSide,
    this.enabledBorderSide,
    this.borderSide,
    this.disableBorderSide,
    this.errorBorderSide,
    this.contentPadding,
    this.keyboardType,
    this.minLines,
    this.maxLines,
    this.textAlign,
    this.textFieldFillColor,
  }) : super(key: key);

  final TextEditingController editingController;
  final FocusNode focusNode;
  final Size size;
  final Widget? prefixIcon;
  final String? labelText;
  final String? hintText;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final BorderSide? enabledBorderSide;
  final BorderSide? focusedBorderSide;
  final BorderSide? borderSide;
  final BorderSide? disableBorderSide;
  final BorderSide? errorBorderSide;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final Color? textFieldFillColor;

  final int? minLines;
  final int? maxLines;

  final EdgeInsetsGeometry? contentPadding;

  @override
  State<InputTextFieldForm> createState() => _InputTextFieldFormState();
}

class _InputTextFieldFormState extends State<InputTextFieldForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height,
      width: widget.size.width,
      alignment: Alignment.center,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        autofocus: false,
        textAlign: widget.textAlign ?? TextAlign.left,
        focusNode: widget.focusNode,
        controller: widget.editingController,
        keyboardType: widget.keyboardType,
        style: widget.style,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          fillColor: widget.textFieldFillColor ?? Colors.white,
          contentPadding: widget.contentPadding ??
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          filled: true,
          isCollapsed: true,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          enabledBorder: OutlineInputBorder(
            /*边角*/
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            borderSide: widget.enabledBorderSide ??
                BorderSide(
                  color: Colors.transparent, //边线颜色为黄色
                  width: 0, //边线宽度为1
                ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0), //边角为30
            ),
            borderSide: widget.focusedBorderSide ??
                BorderSide(
                  color: Colors.transparent,
                  width: 0, //宽度为1
                ),
          ),
          disabledBorder: OutlineInputBorder(
            /*边角*/
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            borderSide: widget.disableBorderSide ??
                BorderSide(
                  color: Colors.transparent, //边线颜色为黄色
                  width: 0, //边线宽度为1
                ),
          ),
          border: OutlineInputBorder(
            /*边角*/
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            borderSide: widget.borderSide ??
                BorderSide(
                  color: Colors.transparent, //边线颜色为黄色
                  width: 0, //边线宽度为1
                ),
          ),
          errorBorder: OutlineInputBorder(
            /*边角*/
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            borderSide: widget.errorBorderSide ??
                BorderSide(
                  color: Colors.transparent, //边线颜色为黄色
                  width: 0, //边线宽度为1
                ),
          ),
          prefixIcon: widget.prefixIcon,
        ),
      ),
    );
  }
}

// 表单提交按钮
class FormSubmitButton extends StatelessWidget {
  const FormSubmitButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.buttonEnabled = false,
    this.atLogining = false,
    this.color,
    this.bgHighlightedColor,
    this.highlightedColor,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool buttonEnabled;
  final atLogining; // 点击按钮进入登录中，放置多次点击
  final Widget child;
  final double? width;
  final double? height;
  final Color? color;
  final Color? highlightedColor;
  final Color? bgHighlightedColor;

  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      child: (atLogining
          ? FormProgressIndicator(
              size: Size(22.0, 22.0),
            )
          : buildButton()),
    );
  }

  Widget buildButton() {
    return ButtonWidget(
      onPressed: onPressed,
      child: child,
      width: width,
      height: height,
      highlightedColor: highlightedColor ?? Colors.red,
      bgColor: color ?? Colors.blue,
      bgHighlightedColor: bgHighlightedColor ?? Colors.cyan,
      enabled: buttonEnabled,
      bgDisableColor: Colors.grey,
      borderRadius: borderRadius,
      iconTextPadding: 8,
    );
  }
}

class FormProgressIndicator extends StatelessWidget {
  const FormProgressIndicator({required this.size, Key? key}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: CupertinoActivityIndicator(
          animating: true,
          radius: size.height / 2.0,
        ),
      ),
    );
  }
}
