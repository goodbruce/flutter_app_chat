import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/provider/view_state.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// 加载中
class ViewStateBusyWidget extends StatelessWidget {
  const ViewStateBusyWidget({this.bgColor, Key? key}) : super(key: key);

  final Color? bgColor;

  Color getColorAtIndex(int index) {
    if (index == 0) {
      return Colors.deepOrangeAccent;
    }

    if (index == 1) {
      return Colors.redAccent;
    }

    if (index == 2) {
      return Colors.deepOrangeAccent;
    }

    return Colors.white70;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor != null ? bgColor : Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300.0,
              height: 60.0,
              child: SpinKitThreeBounce(
                size: 40.0,
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                      decoration: BoxDecoration(
                          color: getColorAtIndex(index),
                          shape: BoxShape.circle));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 基础Widget
class ViewStateWidget extends StatelessWidget {
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final String? buttonTextData;
  final VoidCallback onPressed;
  final Color? bgColor;

  ViewStateWidget(
      {Key? key,
      this.image,
      this.message,
      this.buttonText,
      this.bgColor,
      required this.onPressed,
      this.buttonTextData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor != null ? bgColor : Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          image ??
              Container(
                height: 30,
              ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  message ?? '',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: ColorUtil.hexColor(0x777777),
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: (buttonText != null ||
                    (buttonTextData != null && buttonTextData!.isNotEmpty))
                ? ViewStateButton(
                    child: buttonText,
                    textData: buttonTextData,
                    onPressed: onPressed,
                  )
                : Container(),
          ),
          SizedBox(height: 60.0),
        ],
      ),
    );
  }
}

/// ErrorWidget 报错Widget
class ViewStateErrorWidget extends StatelessWidget {
  final ViewStateError error;
  final String? title;
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final String? buttonTextData;
  final VoidCallback onPressed;

  const ViewStateErrorWidget({
    Key? key,
    required this.error,
    this.image,
    this.title,
    this.message,
    this.buttonText,
    this.buttonTextData,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var defaultImage;
    var defaultTitle;
    var errorMessage = error.errorMessage;
    String defaultTextData = "重试一下";
    switch (error.errorType) {
      case ViewStateErrorType.networkTimeOutError:
        defaultImage = Icon(
          Icons.network_check_outlined,
          size: 80,
          color: ColorUtil.hexColor(0xbcbcbc),
        );
        defaultTitle = "网络链接异常";
        break;
      case ViewStateErrorType.defaultError:
        defaultImage = Icon(
          Icons.error_outline_sharp,
          size: 80,
          color: ColorUtil.hexColor(0xbcbcbc),
        );
        defaultTitle = "加载失败";
        break;

      case ViewStateErrorType.unauthorizedError:
        return ViewStateUnAuthWidget(
          image: image,
          message: message,
          buttonText: buttonText,
          onPressed: onPressed,
        );
    }

    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? defaultImage,
      message: stateMessage(message, errorMessage, defaultTitle),
      buttonTextData: buttonTextData ?? defaultTextData,
      buttonText: buttonText,
    );
  }

  String stateMessage(String? message, String? errorMessage, String defaultTitle) {
    if (message != null && message.isNotEmpty) {
      return message;
    }

    if (errorMessage != null && errorMessage.isNotEmpty) {
      return errorMessage;
    }

    return defaultTitle;
  }
}

/// 页面无数据
class ViewStateEmptyWidget extends StatelessWidget {
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final String? buttonTextData;
  final VoidCallback onPressed;

  const ViewStateEmptyWidget(
      {Key? key,
      this.image,
      this.message = "",
      this.buttonText,
      this.buttonTextData,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      child: ViewStateWidget(
        onPressed: this.onPressed,
        image: image,
        message: message ?? "暂无数据",
        buttonText: buttonText,
        buttonTextData: buttonTextData,
      ),
    );
  }
}

/// 页面未授权
class ViewStateUnAuthWidget extends StatelessWidget {
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final VoidCallback onPressed;

  const ViewStateUnAuthWidget(
      {Key? key,
      this.image,
      this.message,
      this.buttonText,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? ViewStateUnAuthImage(),
      message: message ?? "未登录，请登录",
      buttonText: buttonText,
      buttonTextData: "去登录",
    );
  }
}

/// 未授权图片
class ViewStateUnAuthImage extends StatelessWidget {
// @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'loginLogo',
      child: Image.asset(
        ImageHelper.wrapAssets('login_logo.png'),
        width: 130,
        height: 100,
        fit: BoxFit.fitWidth,
        color: Theme.of(context).accentColor,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }
}

/// 公用Button
class ViewStateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;
  final String? textData;

  const ViewStateButton(
      {Key? key, required this.onPressed, this.child, this.textData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 44.0,
      decoration: BoxDecoration(
        color: ColorUtil.hexColor(0xf0f0f0),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: ColorUtil.hexColor(0xf0f0f0),
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      child: TextButton(
        child: child ??
            Text(
              textData ?? "重试",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                color: ColorUtil.hexColor(0x3b93ff),
                decoration: TextDecoration.none,
              ),
            ),
        onPressed: onPressed,
      ),
    );
  }
}
