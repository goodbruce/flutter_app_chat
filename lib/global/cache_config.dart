class CacheConfig {
  bool? _enable; // 是否启用缓存
  int? _maxAge;  // 缓存的最长时间，单位（秒）
  int? _maxCount;// 最大缓存数

  CacheConfig({bool? enable, int? maxAge, int? maxCount}) {
    if (enable != null) {
      this._enable = enable;
    }
    if (maxAge != null) {
      this._maxAge = maxAge;
    }
    if (maxCount != null) {
      this._maxCount = maxCount;
    }
  }

  bool? get enable => _enable;
  set enable(bool? enable) => _enable = enable;
  int? get maxAge => _maxAge;
  set maxAge(int? maxAge) => _maxAge = maxAge;
  int? get maxCount => _maxCount;
  set maxCount(int? maxCount) => _maxCount = maxCount;

  CacheConfig.fromJson(Map<String, dynamic> json) {
    _enable = json['enable'];
    _maxAge = json['maxAge'];
    _maxCount = json['maxCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enable'] = this._enable;
    data['maxAge'] = this._maxAge;
    data['maxCount'] = this._maxCount;
    return data;
  }
}
