import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_app_chat/channel/my_navigator_observer.dart';
import 'package:flutter_app_chat/config/provider_manager.dart';
import 'package:flutter_app_chat/config/router_manager.dart';
import 'package:flutter_app_chat/generated/l10n.dart';
import 'package:flutter_app_chat/global/app_model.dart';
import 'package:flutter_app_chat/global/locale_model.dart';
import 'package:flutter_app_chat/global/theme_model.dart';
import 'package:flutter_app_chat/global/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class QunMyApp extends StatefulWidget {
  const QunMyApp({Key? key}) : super(key: key);

  @override
  State<QunMyApp> createState() => _QunMyAppState();
}

class _QunMyAppState extends State<QunMyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer3<ThemeModel, LocaleModel, UserModel>(
        builder: (context, themeModel, localeModel, userModel, child) {
          return RefreshConfiguration(
            hideFooterWhenNotFull: false, //列表数据不满一页,不触发加载更多
            child: ScreenUtilInit(
              designSize: const Size(375.0, 667.0),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return child ??
                    buildMaterialApp(
                        context, localeModel, themeModel, userModel);
              },
              child:
              buildMaterialApp(context, localeModel, themeModel, userModel),
            ),
          );
        },
      ),
    );
  }

  Widget buildMaterialApp(BuildContext context, LocaleModel localeModel,
      ThemeModel themeModel, UserModel userModel) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "PingFang SC",
        primarySwatch: themeModel.theme,
      ),
      navigatorKey: OneContext().key,
      debugShowCheckedModeBanner: false,
      supportedLocales: S.delegate.supportedLocales,
      locale: localeModel.getLocale(),
      initialRoute: RouterName.conversation,
      onGenerateRoute: RouterManager.generateRoute,
      navigatorObservers: buildObservers(),
      localizationsDelegates: const [
        S.delegate,
        RefreshLocalizations.delegate, //下拉刷新
      ],
      localeResolutionCallback: (_locale, supportedLocales) {
        if (localeModel.getLocale() != null) {
          //如果已经选定语言，则不跟随系统
          return localeModel.getLocale();
        } else {
          //跟随系统
          print("_locale：${_locale}");
          Locale locale;
          if (supportedLocales.contains(_locale)) {
            locale = _locale!;
          } else {
            //如果系统语言不是中文简体或美国英语，则默认使用美国英语
            locale = Locale('en', 'US');
          }
          return locale;
        }
      },
      builder: EasyLoading.init(builder: (BuildContext context, Widget? child) {
        return OneContext().builder(
          context,
          child,
          observers: buildObservers(),
        );
      }),
      home: buildGlobalGesture(context),
    );
  }

  Widget buildGlobalGesture(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
          // 也可以使用如下方式隐藏键盘：
          // SystemChannels.textInput.invokeMethod('TextInput.hide');
        }
      },
    );
  }

  List<NavigatorObserver> buildObservers() {
    return [MyNavigatorObserver()];
  }
}
