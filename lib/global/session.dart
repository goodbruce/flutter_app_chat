import 'package:flutter_app_chat/global/cache_config.dart';
import 'package:flutter_app_chat/global/user.dart';

class Session {
  User? _user;
  String? _token;

  /// rtcUserId 直播用户Id IM的用户id
  String? _imUserId;
  /// 腾讯IM的用户Sign
  String? _imUserSign;


  int? _theme;
  CacheConfig? _cache;
  String? _lastLogin;
  String? _locale;

  // 用户是否统一协议
  String? _isUserAgree;

  Session(
      {User? user,
      String? token, String? imUserId,
        String? imUserSign,
      int? theme,
      CacheConfig? cache,
      String? lastLogin,
      String? locale,
      String? isUserAgree}) {

    if (user != null) {
      this._user = user;
    }
    if (token != null) {
      this._token = token;
    }
    if (imUserId != null) {
      this._imUserId = imUserId;
    }
    if (imUserSign != null) {
      this._imUserSign = imUserSign;
    }
    if (theme != null) {
      this._theme = theme;
    }
    if (cache != null) {
      this._cache = cache;
    }
    if (lastLogin != null) {
      this._lastLogin = lastLogin;
    }
    if (locale != null) {
      this._locale = locale;
    }
    if (isUserAgree != null) {
      this._isUserAgree = isUserAgree;
    }
  }

  User? get user => _user;

  set user(User? user) => _user = user;

  String? get token => _token;

  set token(String? token) => _token = token;

  String? get imUserId => _imUserId;

  set imUserId(String? imUserId) => _imUserId = imUserId;

  String? get imUserSign => _imUserSign;

  set imUserSign(String? imUserSign) => _imUserSign = imUserSign;

  int? get theme => _theme;

  set theme(int? theme) => _theme = theme;

  CacheConfig? get cache => _cache;

  set cache(CacheConfig? cache) => _cache = cache;

  String? get lastLogin => _lastLogin;

  set lastLogin(String? lastLogin) => _lastLogin = lastLogin;

  String? get locale => _locale;

  set locale(String? locale) => _locale = locale;

  String? get isUserAgree => _isUserAgree;

  set isUserAgree(String? isUserAgree) => _isUserAgree = isUserAgree;

  Session.fromJson(Map<String, dynamic> json) {
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
    _token = json['token'];
    _imUserId = json['imUserId'];
    _imUserSign = json['imUserSign'];
    _theme = json['theme'];
    _cache =
        json['cache'] != null ? new CacheConfig.fromJson(json['cache']) : null;
    _lastLogin = json['lastLogin'];
    _locale = json['locale'];
    _isUserAgree = json['isUserAgree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._user != null) {
      data['user'] = this._user!.toJson();
    }
    data['token'] = this._token;
    data['imUserId'] = this._imUserId;
    data['imUserSign'] = this._imUserSign;
    data['theme'] = this._theme;
    if (this._cache != null) {
      data['cache'] = this._cache!.toJson();
    }
    data['lastLogin'] = this._lastLogin;
    data['locale'] = this._locale;
    data['isUserAgree'] = this._isUserAgree;
    return data;
  }
}
