import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageHelper {
  static const String baseUrl = '';
  static const String imagePrefix = '$baseUrl/uimg/';

  static String wrapUrl(String url) {
    if (url.startsWith('http')) {
      return url;
    } else {}
    return imagePrefix + url;
  }

  static AssetImage assetImageAtImages(String url) {
    String image = "assets/images/" + url;
    return AssetImage(image);
  }

  static String wrapAssets(String url) {
    String image = "assets/images/" + url;
    return image;
  }

  static Image wrapAssetAtImages(String name,
      {double? width, double? height, BoxFit? fit}) {
    return Image.asset(
      "assets/images/" + name,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, url, error) =>
          imageErrorHolder(width: width, height: height),
    );
  }

  // 处理网络图片的url
  static Widget imageNetwork(
      {required String imageUrl,
      double? width,
      double? height,
      BoxFit? fit,
      Widget? placeholder,
      Widget? errorHolder}) {

    double? cacheWidth;
    if (width != null) {
      cacheWidth = width * 2.0;
    }

    double? cacheHeight;
    if (height != null) {
      cacheHeight = height * 2.0;
    }

    if (!(imageUrl.isNotEmpty && imageUrl.startsWith("http"))) {
      return Container();
    }

    String aCropImageUrl = ImageHelper.formatImageUrl(
        imageUrl: imageUrl, width: cacheWidth, height: cacheHeight);

    return CachedNetworkImage(
      maxWidthDiskCache: cacheWidth?.round(),
      maxHeightDiskCache: cacheHeight?.round(),
      imageUrl: aCropImageUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) => (placeholder ?? Container()),
      errorWidget: (context, url, error) =>
          (errorHolder ?? imageErrorHolder(width: width, height: height)),
    );
  }

  static Widget imageErrorHolder({double? width, double? height}) {
    return Container(
      width: width,
      height: height,
    );
  }

  static Widget placeHolder({double? width, double? height}) {
    return SizedBox(
        width: width,
        height: height,
        child: CupertinoActivityIndicator(radius: min(10.0, width! / 3)));
  }

  static Widget error({double? width, double? height, double? size}) {
    return SizedBox(
        width: width,
        height: height,
        child: Icon(
          Icons.error_outline,
          size: size,
        ));
  }

  static String formatImageUrl(
      {required String imageUrl, double? width, double? height}) {
    return imageUrl;
  }

  static String randomUrl(
      {int width = 100, int height = 100, Object key = ''}) {
    return 'http://placeimg.com/$width/$height/${key.hashCode.toString() + key.toString()}';
  }
}

class IconFonts {
  IconFonts._();

  /// iconfont:flutter base
  static const String fontFamily = 'iconfont';

  static const IconData pageEmpty = IconData(0xe63c, fontFamily: fontFamily);
  static const IconData pageError = IconData(0xe600, fontFamily: fontFamily);
  static const IconData pageNetworkError =
      IconData(0xe678, fontFamily: fontFamily);
  static const IconData pageUnAuth = IconData(0xe65f, fontFamily: fontFamily);
}
