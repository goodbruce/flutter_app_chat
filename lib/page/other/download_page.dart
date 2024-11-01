import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/navigator_route.dart';
import 'package:flutter_app_chat/network/http_api.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/utils/platform_utils.dart';
import 'package:flutter_app_chat/widget/base_widget/appbar_icon_button.dart';
import 'package:flutter_app_chat/widget/base_widget/button_widget.dart';
import 'package:flutter_app_chat/widget/common_widget/show_loading_hud.dart';
import 'package:path_provider/path_provider.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({
    Key? key,
    this.messages,
    this.uniqueId,
    this.arguments,
  }) : super(key: key);

  final Object? arguments;
  final String? messages;
  final String? uniqueId;

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  String _downloadPath =
      'https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg';
  double _downloadRatio = 0.0;
  String _downloadIndicator = '0.00%';
  late String _destPath;
  late CancelToken _token;
  bool _downloading = false;

  @override
  void initState() {
    getTemporaryDirectory()
        .then((tempDir) => {_destPath = tempDir.path + 'googlechrome.dmg'});

    super.initState();
  }

  void _downloadFile() {
    if (_downloading == true) {
      return;
    }
    _token = CancelToken();
    _downloading = true;
    HttpApi().doDownload(_downloadPath, _destPath, cancelToken: _token,
        progress: (int received, int total) {
      // 下载进度
      setState(() {
        _downloadRatio = (received / total);
        if (_downloadRatio == 1) {
          _downloading = false;
        }
        _downloadIndicator = (_downloadRatio * 100).toStringAsFixed(2) + '%';
      });
    }, completion: () {
      // 下载成功
      _downloading = false;
      FlutterLoadingHud.showToast(message: "\"下载完成\"");
    }, failure: (error) {
      // 下载出错
      _downloading = false;
      FlutterLoadingHud.showToast(message: error.message);
    });
  }

  void _cancelDownload() {
    if (_downloadRatio < 1.0) {
      _token.cancel();
      _downloading = false;
      setState(() {
        _downloadRatio = 0;
        _downloadIndicator = '0.00%';
      });
    }
  }

  void _deleteFile() {
    try {
      File downloadedFile = File(_destPath);
      if (downloadedFile.existsSync()) {
        downloadedFile.delete();
      } else {
        FlutterLoadingHud.showToast(message: "文件不存在");
      }
    } catch (e) {
      FlutterLoadingHud.showToast(
          message: "${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: AppBarIconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {NavigatorRoute.pop()},
        ),
        centerTitle: true,
        backgroundColor: ColorUtil.hexColor(0xffffff),
        foregroundColor: ColorUtil.hexColor(0x777777),
        elevation: 0,
        title: Text(
          "下载示例",
          textAlign: TextAlign.center,
          softWrap: true,
          style: TextStyle(
            fontSize: 17,
            color: ColorUtil.hexColor(0x333333),
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
          ),
        ),
        shadowColor: ColorUtil.hexColor(0xffffff),
        toolbarHeight: 44.0,
        bottomOpacity: 0.0,
      ),
      body: Container(
        color: ColorUtil.hexColor(0xf7f7f7),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                _buildDownloadButton(),
                TextButton(
                  child: Text('取消'),
                  onPressed: () {
                    _cancelDownload();
                  },
                ),
                TextButton(
                  child: Text(
                    '删除',
                    style: TextStyle(
                        color: !_downloading ? Colors.red : Colors.grey),
                  ),
                  onPressed: (!_downloading ? _deleteFile : null),
                  style: ButtonStyle(),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(children: [
              Expanded(
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[600],
                  value: _downloadRatio,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                _downloadIndicator,
                style: TextStyle(color: Colors.black, fontSize: 12.0),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadButton() {
    return ButtonWidget(
      onPressed: () {
        _downloadFile();
      },
      child: Text(
        "下载文件",
        textAlign: TextAlign.center,
        softWrap: true,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          color: ColorUtil.hexColor(0xffffff),
          decoration: TextDecoration.none,
        ),
      ),
      height: 40,
      width: 100.0,
      highlightedColor: ColorUtil.hexColor(0xff462e),
      bgColor: ColorUtil.hexColor(0xff462e),
      bgHighlightedColor: ColorUtil.hexColor(0xff462e, alpha: 0.75),
      enabled: true,
      bgDisableColor: Colors.grey,
      borderRadius: 22.0,
    );
  }
}
