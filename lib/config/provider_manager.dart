import 'package:flutter_app_chat/global/app_model.dart';
import 'package:flutter_app_chat/global/g_cache_model.dart';
import 'package:flutter_app_chat/global/locale_model.dart';
import 'package:flutter_app_chat/global/theme_model.dart';
import 'package:flutter_app_chat/global/user_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices
];

/// 独立的model
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider<AppModel>(
    create: (context) => AppModel(),
  ),
  ChangeNotifierProvider<LocaleModel>(
    create: (context) => LocaleModel(),
  ),
  ChangeNotifierProvider<ThemeModel>(
    create: (context) => ThemeModel(),
  ),
  ChangeNotifierProvider<GlobalCacheModel>(
    create: (context) => GlobalCacheModel(),
  )
];

/// 需要依赖的model
///
/// UserModel依赖GlobalCacheModel
List<SingleChildWidget> dependentServices = [
  ChangeNotifierProxyProvider<GlobalCacheModel, UserModel>(
    create: (context) => UserModel(
      globalCacheModel: Provider.of<GlobalCacheModel>(context, listen: false),
    ),
    update: (context, globalCacheModel, userModel) =>
    userModel ?? UserModel(globalCacheModel: globalCacheModel),
  ),
];
