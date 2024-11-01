class User {
  String? _userId;
  String? _nickName;
  String? _avatar;

  User({String? userId, String? nickName, String? avatar}) {
    if (userId != null) {
      this._userId = userId;
    }
    if (nickName != null) {
      this._nickName = nickName;
    }
    if (avatar != null) {
      this._avatar = avatar;
    }
  }

  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;
  String? get nickName => _nickName;
  set nickName(String? nickName) => _nickName = nickName;
  String? get avatar => _avatar;
  set avatar(String? avatar) => _avatar = avatar;

  User.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _nickName = json['nickName'];
    _avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this._userId;
    data['nickName'] = this._nickName;
    data['avatar'] = this._avatar;
    return data;
  }
}