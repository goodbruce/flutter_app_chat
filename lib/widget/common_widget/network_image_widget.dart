import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum NetworkImageBoxFit { Fill, AspectFit, AspectFill }

class NetworkImageWidget extends StatefulWidget {
  const NetworkImageWidget({
    Key? key,
    required this.imageUrl,
    this.boxFit = NetworkImageBoxFit.AspectFill,
    this.width = 0,
    this.height = 0,
    this.placeholder,
    this.errorHolder,
  }) : super(key: key);

  final String imageUrl;

  final NetworkImageBoxFit boxFit;

  final double width;
  final double height;

  final Widget? placeholder;
  final Widget? errorHolder;

  @override
  _NetworkImageWidgetState createState() => _NetworkImageWidgetState();
}

class _NetworkImageWidgetState extends State<NetworkImageWidget> {
  final MethodChannel _channel = MethodChannel('df_texture_channel'); //名称随意, 2端统一就好

  int textureId = -1; //系统返回的正常id会大于等于0, -1则可以认为 还未加载纹理

  @override
  void initState() {
    super.initState();

    newTexture();
  }

  @override
  void dispose() {
    super.dispose();
    if (textureId >= 0) {
      _channel.invokeMethod('dispose', {'textureId': textureId});
    }
  }

  BoxFit textureBoxFit(NetworkImageBoxFit imageBoxFit) {
    if (imageBoxFit == NetworkImageBoxFit.Fill) {
      return BoxFit.fill;
    }

    if (imageBoxFit == NetworkImageBoxFit.AspectFit) {
      return BoxFit.contain;
    }

    if (imageBoxFit == NetworkImageBoxFit.AspectFill) {
      return BoxFit.cover;
    }
    return BoxFit.fill;
  }

  Widget showTextureWidget(BuildContext context) {
    return Container(
      color: Colors.white,
      width: widget.width,
      height: widget.height,
      child: Texture(textureId: textureId),
    );
  }

  void newTexture() async {
    int aTextureId = await _channel.invokeMethod('create', {
      'imageUrl': widget.imageUrl, //本地图片名
      'width': widget.width,
      'height': widget.height,
      'asGif': false, //是否是gif,也可以不这样处理, 平台端也可以自动判断
    });
    setState(() {
      textureId = aTextureId;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body = textureId >= 0
        ? showTextureWidget(context)
        : showDefault() ??
            Container(
              color: Colors.white,
              width: widget.width,
              height: widget.height,
            );

    return body;
  }

  Widget? showDefault() {
    if (widget.placeholder != null) {
      return widget.placeholder;
    }

    if (widget.errorHolder != null) {
      return widget.errorHolder;
    }

    return Container(
      color: Colors.white,
      width: widget.width,
      height: widget.height,
    );
  }
}
