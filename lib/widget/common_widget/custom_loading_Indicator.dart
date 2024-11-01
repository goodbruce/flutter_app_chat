import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';

// 旋转loading指示器
class CustomLoadingIndicator extends StatefulWidget {
  const CustomLoadingIndicator({Key? key}) : super(key: key);

  @override
  State<CustomLoadingIndicator> createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator> with TickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _disposed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _disposed = false;

    startAnimation();
  }

  void startAnimation() {
    if (_disposed == true) {
      return;
    }

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animation = Tween(begin: 0.0, end: 2*pi).animate(_animation);

    _animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        startAnimation();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _disposed = true;
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      color: Colors.transparent,
      alignment: Alignment.center,
      child: Transform.rotate(
        //旋转90度
        angle:_animation.value,
        child: _buildLoadingWidget(context),
      ),
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return ImageHelper.wrapAssetAtImages(
      "icons/ic_toast_loading.png",
      width: 50.0,
      height: 50.0,
    );
  }
}
