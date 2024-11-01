import 'package:flutter/material.dart';

// 操作的icon类型
enum CommMoreOptionIconType {
  commMoreOptionIconFile,       //默认
  commMoreOptionIconUrl,        // icon为url
}

// 默认的三个
const String kOptionCamera = "camera";
const String kOptionAlbum = "album";
const String kOptionCoupon = "coupon";

// 更多操作的item
class CommMoreOption {

  String? name;
  String? icon;
  int? appId;
  String? path;     // 路径
  String? appletId; // 小程序id
  String? linkUrl;  // 跳转url
  int? type;        //类型 0本地 1跳转url 2小程序跳转
  int? navType;

  CommMoreOptionIconType iconType = CommMoreOptionIconType.commMoreOptionIconFile;
}