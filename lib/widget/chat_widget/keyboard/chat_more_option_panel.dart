import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/config/router_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/base_widget/button_widget.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_event_bus.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_more_option.dart';
import 'package:flutter_app_chat/widget/chat_widget/keyboard/chat_input_bar_controller.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

// 中间间隔
const double kOptionSperate = 15.0;
const double kSwiperPaginationHeight = 10.0;

const int kGridCrossAxisCount = 4;
const int kGridCrossAxisRow = 2;

// 更多操作
class ChatMoreOptionPanel extends StatefulWidget {
  const ChatMoreOptionPanel({
    Key? key,
    required this.morePanelHeight,
    required this.chatInputBarController,
    required this.moreOptionEntries,
  }) : super(key: key);

  final double morePanelHeight;
  final ChatInputBarController chatInputBarController;
  final List<CommMoreOption> moreOptionEntries;

  @override
  State<ChatMoreOptionPanel> createState() => _ChatMoreOptionPanelState();
}

class _ChatMoreOptionPanelState extends State<ChatMoreOptionPanel> {
  List<CommMoreOption> allOptionList = [];

  List<List<CommMoreOption>> optionSwiperList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    CommMoreOption commMoreOption = CommMoreOption();
    commMoreOption.icon = "file://ic_toolbar_camera.png";
    commMoreOption.name = "相机";
    commMoreOption.iconType = CommMoreOptionIconType.commMoreOptionIconFile;
    commMoreOption.type = 0;
    commMoreOption.linkUrl = kOptionCamera;
    allOptionList.add(commMoreOption);

    CommMoreOption commMoreOption1 = CommMoreOption();
    commMoreOption1.icon = "file://ic_toolbar_ablum.png";
    commMoreOption1.name = "相册";
    commMoreOption1.iconType = CommMoreOptionIconType.commMoreOptionIconFile;
    commMoreOption1.type = 0;
    commMoreOption1.linkUrl = kOptionAlbum;
    allOptionList.add(commMoreOption1);

    CommMoreOption commMoreOption2 = CommMoreOption();
    commMoreOption2.icon = "file://ic_toolbar_coupon.png";
    commMoreOption2.name = "卡券";
    commMoreOption2.iconType = CommMoreOptionIconType.commMoreOptionIconFile;
    commMoreOption2.type = 0;
    commMoreOption2.linkUrl = kOptionCoupon;
    allOptionList.add(commMoreOption2);

    if (widget.moreOptionEntries.isNotEmpty) {
      allOptionList.addAll(widget.moreOptionEntries);
    }

    handlerSwiperList();
  }

  void handlerSwiperList() {
    List<List<CommMoreOption>> tmpOptionSwiperList = [];
    int aPageNum = kGridCrossAxisCount * kGridCrossAxisRow;
    int swiperCount = (allOptionList.length % aPageNum == 0
            ? allOptionList.length / aPageNum
            : (allOptionList.length / aPageNum + 1))
        .toInt();
    for (int i = 0; i < swiperCount; i++) {
      int location = 0;
      int length = 0;

      location = i * aPageNum;
      if (i == 0) {
        length =
            aPageNum > allOptionList.length ? allOptionList.length : aPageNum;
      } else {
        length = (1 + i) * aPageNum > allOptionList.length
            ? (allOptionList.length - i * aPageNum)
            : aPageNum;
      }

      List<CommMoreOption> swiperItems =
          allOptionList.sublist(location, (location + length));
      tmpOptionSwiperList.add(swiperItems);
    }
    optionSwiperList = tmpOptionSwiperList;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // 点击不同的操作Option
  void onMoreOptionPressed(CommMoreOption commMoreOption) {
    // 点击不同的操作Option
    // 发送eventBus事件
    CommEventBusModel eventBusModel = CommEventBusModel(
      commEventBusType: CommEventBusType.commEventBusTypeMoreOption,
      data: commMoreOption,
    );
    kCommEventBus.fire(eventBusModel);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: widget.morePanelHeight,
      decoration: BoxDecoration(
        color: ColorUtil.hexColor(0xf7f7f7),
      ),
      padding: EdgeInsets.only(
        left: 0.0,
        right: 0.0,
        bottom: 0.0,
        top: 0.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Swiper(
              // 横向
              scrollDirection: Axis.horizontal,
              // 布局构建
              itemBuilder: (BuildContext context, int index) {
                List<CommMoreOption> optionList = optionSwiperList[index];
                return ChatMoreOptionSwiperContainer(
                  moreOptions: optionList,
                  onMoreOptionPressed: (CommMoreOption commMoreOption) {
                    onMoreOptionPressed(commMoreOption);
                  },
                );
              },
              //条目个数
              itemCount: optionSwiperList.length,
              // 自动翻页
              autoplay: false,
              // 分页指示
              pagination: SwiperPagination(
                //指示器显示的位置 Alignment.bottomCenter 底部中间
                alignment: Alignment.bottomCenter,
                // 距离调整
                margin: const EdgeInsets.only(bottom: 0.0),
                // 指示器构建
                builder: DotSwiperPaginationBuilder(
                  // 点之间的间隔
                  space: 3,
                  // 没选中时的大小
                  size: 6,
                  // 选中时的大小
                  activeSize: 6,
                  // 没选中时的颜色
                  color: ColorUtil.hexColor(0xDCDCDC),
                  //选中时的颜色
                  activeColor: ColorUtil.hexColor(0xff462e),
                ),
              ),
              // pagination: _buildSwiperPagination(),
              // pagination: _buildNumSwiperPagination(),
              //点击事件
              onTap: (index) {
                print(" 点击 " + index.toString());
              },
              // 相邻子条目视窗比例
              viewportFraction: 1,
              // 用户进行操作时停止自动翻页
              autoplayDisableOnInteraction: true,
              // 无限轮播
              loop: false,
              //当前条目的缩放比例
              scale: 1,
            ),
          ),
          buildAreaBottom(context),
        ],
      ),
    );
  }

  Widget buildAreaBottom(BuildContext context) {
    EdgeInsets viewPadding = MediaQuery.of(context).viewPadding;
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: ColorUtil.hexColor(0xf7f7f7),
      ),
      height: viewPadding.bottom,
      width: screenSize.width,
    );
  }
}

// 一个swiper的容器
class ChatMoreOptionSwiperContainer extends StatefulWidget {
  const ChatMoreOptionSwiperContainer({
    Key? key,
    required this.moreOptions,
    required this.onMoreOptionPressed,
  }) : super(key: key);

  final List<CommMoreOption> moreOptions;
  final Function(CommMoreOption commMoreOption) onMoreOptionPressed;

  @override
  State<ChatMoreOptionSwiperContainer> createState() =>
      _ChatMoreOptionSwiperContainerState();
}

class _ChatMoreOptionSwiperContainerState
    extends State<ChatMoreOptionSwiperContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: kGridCrossAxisCount, //每行三列
          childAspectRatio: 1.0, //显示区域宽高相等
        ),
        itemCount: widget.moreOptions.length,
        itemBuilder: (context, index) {
          CommMoreOption commMoreOption = widget.moreOptions[index];
          return ChatMoreOptionButton(
            onMoreOptionPressed: widget.onMoreOptionPressed,
            commMoreOption: commMoreOption,
          );
        },
      ),
    );
  }
}

// 每个option的大小
class ChatMoreOptionButton extends StatelessWidget {
  const ChatMoreOptionButton({
    Key? key,
    required this.commMoreOption,
    required this.onMoreOptionPressed,
  }) : super(key: key);

  final CommMoreOption commMoreOption;
  final Function(CommMoreOption commMoreOption) onMoreOptionPressed;

  @override
  Widget build(BuildContext context) {
    EdgeInsets viewPadding = MediaQuery.of(context).viewPadding;
    Size screenSize = MediaQuery.of(context).size;

    double aWidth = (screenSize.width - (kOptionSperate * 5)) / 4;
    double aHeight = (kMorePanelHeight -
            (kOptionSperate * 3) -
            viewPadding.bottom -
            kSwiperPaginationHeight) /
        2;

    double aMin = min(aWidth, aHeight);

    double marginSpace = kOptionSperate / 2;
    return ButtonWidget(
      margin: EdgeInsets.symmetric(
        vertical: marginSpace,
        horizontal: marginSpace,
      ),
      width: aMin,
      height: aMin,
      borderRadius: 6.0,
      bgColor: ColorUtil.hexColor(0xffffff),
      bgHighlightedColor: ColorUtil.hexColor(0xf0f0f0),
      onPressed: () {
        onMoreOptionPressed(commMoreOption);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildButtonIcon(context),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "${commMoreOption.name}",
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              color: ColorUtil.hexColor(0x333333),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtonIcon(BuildContext context) {
    if (CommMoreOptionIconType.commMoreOptionIconFile ==
        commMoreOption.iconType) {
      // 本地图片
      String imageUrl = "${commMoreOption.icon ?? ""}";
      String start = "file://";
      if (imageUrl.startsWith(start)) {
        String imageAssetFile = imageUrl.substring(start.length);

        return ImageHelper.wrapAssetAtImages(
          "icons/${imageAssetFile}",
          fit: BoxFit.cover,
          width: 26.0,
          height: 26.0,
        );
      }
    } else if (CommMoreOptionIconType.commMoreOptionIconUrl ==
        commMoreOption.iconType) {
      // 网络图片
      String imageUrl = "${commMoreOption.icon ?? ""}";
      return ImageHelper.imageNetwork(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: 40.0,
        height: 40.0,
      );
    }

    return Container();
  }
}
