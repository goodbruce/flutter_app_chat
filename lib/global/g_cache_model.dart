import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 全局维护状态
///
class GlobalCacheModel extends ChangeNotifier {
  /// 将页面列表项中所有的收藏状态操作结果存储到集合中.
  ///
  /// [key]为articleId,[value]为bool类型,代表是否收藏
  ///
  /// 设置static的目的是,列表更新时,刷新该map中的值
  static final Map<int, bool> _map = Map();

  /// 列表数据刷新后,同步刷新该map数据
  ///
  /// 在其他终端(如PC端)收藏/取消收藏后,会导致两边状态不一致.
  /// 列表页面刷新后,应该将新的收藏状态同步更新到map
  // static refresh(List<Article> list) {
  //   list.forEach((article) {
  //     if (_map.containsKey(article.id)) {
  //       _map[article.id] = article.collect;
  //     }
  //   });
  // }

  addToMap(int id) {
    _map[id] = true;
    notifyListeners();
  }

  removeFromMap(int id) {
    _map[id] = false;
    notifyListeners();
  }

  /// 用于切换用户后,将该用户所有收藏的文章,对应的状态置为true
  replaceAll(List ids) {
    _map.clear();
    ids.forEach((id) => _map[id] = true);
    notifyListeners();
  }

  contains(id) {
    return _map.containsKey(id);
  }

  operator [](int id) {
    return _map[id];
  }
}