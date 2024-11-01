// 导航的元素
class CommNavigatorEntry {
  String? icon;
  String? name;
  int? appId;
  String? path;     // 路径
  String? appletId; // 小程序id
  String? linkUrl;  // 跳转url
  int? type;        //类型 0本地 1跳转url 2小程序跳转
  int? navType;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['appId'] = this.appId;
    data['path'] = this.path;
    data['appletId'] = this.appletId;
    data['linkUrl'] = this.linkUrl;
    data['type'] = this.type;
    data['navType'] = this.navType;
    return data;
  }
}