import 'dart:math';

import 'package:flutter/material.dart';

/// 定制switch
class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    Key? key,
    required this.value,
    this.bgColor,
    this.bgBorderColor,
    this.bgOpenBorderColor,
    this.bgBorderWidth,
    this.openBgColor,
    this.color,
    this.openColor,
    this.width,
    this.height,
    this.borderColor,
    this.openBorderColor,
    this.borderWidth,
    required this.onChanged,
  }) : super(key: key);

  final bool value;
  final double? width;
  final double? height;
  final Color? bgBorderColor;
  final Color? bgOpenBorderColor;
  final double? bgBorderWidth;
  final Color? bgColor;
  final Color? openBgColor;
  final Color? color;
  final Color? openColor;

  final Color? borderColor;
  final Color? openBorderColor;
  final double? borderWidth;

  final ValueChanged<bool>? onChanged;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<Color?> _bgColorAnimation;
  late Animation<Color?> _bgBorderColorAnimation;
  late Animation<Color?> _borderColorAnimation;

  bool _switchOpen = false;

  Color _bgColor = Colors.black12;
  Color _openBgColor = Colors.lightBlueAccent;
  Color _color = Colors.black26;
  Color _openColor = Colors.lightBlue;

  Color _bgBorderColor = Colors.black12;
  Color _bgOpenBorderColor = Colors.lightBlueAccent;

  Color _borderColor = Colors.black12;
  Color _openBorderColor = Colors.lightBlue;

  double _width = 50.0;
  double _height = 30.0;
  double _minSize = 30.0;

  bool _isAnimating = false; // 动画中

  double _space = 2.0;

  bool _isStartAnimating = false;

  @override
  void initState() {
    // TODO: implement initState
    _switchOpen = widget.value;

    _bgColor = widget.bgColor ?? Colors.black12;
    _openBgColor = widget.openBgColor ?? Colors.lightBlueAccent;
    _color = widget.color ?? Colors.blueGrey;
    _openColor = widget.openColor ?? Colors.lightBlue;

    _bgBorderColor = widget.bgBorderColor ?? Colors.black12;
    _bgOpenBorderColor = widget.bgOpenBorderColor ?? Colors.lightBlueAccent;

    _borderColor = widget.borderColor ?? Colors.black12;
    _openBorderColor = widget.openBorderColor ?? Colors.lightBlue;

    if (widget.width != null && widget.height != null) {
      _width = widget.width!;
      _height = widget.height!;
    }

    _minSize = min(_width, _height) - _space;

    super.initState();

    runAnimation();
  }

  void runAnimation() {
    Color _bgBeginColor;
    Color _bgEndColor;

    Color _beginColor;
    Color _endColor;

    double _beginP;
    double _endP;

    Color _bgBorderBeginColor;
    Color _bgBorderEndColor;

    Color _borderBeginColor;
    Color _borderEndColor;

    if (_switchOpen) {
      _bgBeginColor = _openBgColor;
      _bgEndColor = _bgColor;

      _beginColor = _openColor;
      _endColor = _color;

      _bgBorderBeginColor = _bgOpenBorderColor;
      _bgBorderEndColor = _bgBorderColor;

      _borderBeginColor = _openBorderColor;
      _borderEndColor = _borderColor;

      _beginP = _width - _minSize - _space;
      _endP = _space;
    } else {
      _bgBeginColor = _bgColor;
      _bgEndColor = _openBgColor;

      _beginColor = _color;
      _endColor = _openColor;

      _bgBorderBeginColor = _bgBorderColor;
      _bgBorderEndColor = _bgOpenBorderColor;

      _borderBeginColor = _borderColor;
      _borderEndColor = _openBorderColor;

      _beginP = _space;
      _endP = _width - _minSize - _space;
    }

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    // 移动位置
    _positionAnimation = Tween<double>(
      begin: _beginP,
      end: _endP,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0, 1.0, //间隔，后20%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    _colorAnimation = ColorTween(
      begin: _beginColor,
      end: _endColor,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0, 1.0, //间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    _bgColorAnimation = ColorTween(
      begin: _bgBeginColor,
      end: _bgEndColor,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0, 1.0, //间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    _bgBorderColorAnimation = ColorTween(
      begin: _bgBorderBeginColor,
      end: _bgBorderEndColor,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0, 1.0, //间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    _borderColorAnimation = ColorTween(
      begin: _borderBeginColor,
      end: _borderEndColor,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0, 1.0, //间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isAnimating = false;
        _isStartAnimating = true;

        // 完成
        if (widget.onChanged != null) {
          widget.onChanged!(!_switchOpen);
        }
      }
    });
  }

  void animationDispose() {
    _controller.dispose();
  }

  void onSwitchPressed() {
    if (_isAnimating) {
      return;
    }

    _isAnimating = true;

    if (_isStartAnimating) {
      _switchOpen = !_switchOpen;
    }
    runAnimation();
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double radius = _minSize / 2.0;
    double bgRadius = _height / 2.0;
    return GestureDetector(
      onTap: () {
        onSwitchPressed();
      },
      child: Container(
        width: _width,
        height: _height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: _bgColorAnimation.value,
                borderRadius: BorderRadius.circular(bgRadius),
                border: Border.all(
                  color: _bgBorderColorAnimation.value ?? Colors.transparent,
                  width: widget.bgBorderWidth ?? 0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            Positioned(
              left: _positionAnimation.value,
              child: Container(
                width: _minSize,
                height: _minSize,
                decoration: BoxDecoration(
                  color: _colorAnimation.value,
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(
                    color: _borderColorAnimation.value ?? Colors.transparent,
                    width: widget.borderWidth ?? 0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
