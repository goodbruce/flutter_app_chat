import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/common_widget/custom_loading_Indicator.dart';
import 'package:one_context/one_context.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// 图片预览页面
typedef PhotoPageChanged = void Function(int index);

class PhotoPreviewPage extends StatefulWidget {
  const PhotoPreviewPage({
    Key? key,
    this.photoPageChanged,
    required this.galleryItems,
    this.decoration,
    this.direction = Axis.horizontal,
    required this.defaultImage,
  }) : super(key: key);

  final List galleryItems; //图片列表
  final int defaultImage; //默认第几张
  final PhotoPageChanged? photoPageChanged; //切换图片回调
  final Axis? direction; //图片查看方向
  final BoxDecoration? decoration; //背景设计

  @override
  State<PhotoPreviewPage> createState() => _PhotoPreviewPageState();
}

class _PhotoPreviewPageState extends State<PhotoPreviewPage> {
  late int tempSelect;

  @override
  void initState() {
    // TODO: implement initState
    tempSelect = (widget.defaultImage + 1);
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets viewPadding = MediaQuery.of(context).viewPadding;
    Size screenSize = MediaQuery.of(context).size;

    return Material(
      child: Stack(
        children: [
          PhotoViewGallery.builder(
            loadingBuilder: (
              BuildContext context,
              ImageChunkEvent? event,
            ) {
              return PhotoLoading();
            },
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                maxScale: 2.5,
                minScale: 0.1,
                onTapDown: (
                  BuildContext context,
                  TapDownDetails details,
                  PhotoViewControllerValue controllerValue,
                ) {
                  OneContext().pop();
                },
                imageProvider: NetworkImage(widget.galleryItems[index]),
              );
            },
            scrollDirection: widget.direction ?? Axis.horizontal,
            itemCount: widget.galleryItems.length,
            backgroundDecoration:
                widget.decoration ?? BoxDecoration(color: Colors.black),
            pageController: PageController(initialPage: widget.defaultImage),
            onPageChanged: (index) => setState(() {
              tempSelect = index + 1;
              if (widget.photoPageChanged != null) {
                widget.photoPageChanged!(index);
              }
            }),
          ),
          // Container(
          //   alignment: Alignment.center,
          //   child: InteractiveViewer(
          //     ///只能沿着坐标轴滑动，就是横着或者竖着滑动
          //     alignPanAxis: true,
          //     ///是否能够用手指滑动
          //     panEnabled: true,
          //     ///子控件可以移动的范围
          //     // boundaryMargin: EdgeInsets.all(400),
          //     ///是否开启缩放
          //     scaleEnabled: true,
          //     ///放大系数
          //     maxScale: 2.5,
          //     ///缩小系数
          //     minScale: 0.3,
          //     ///是否约束
          //     constrained: false,
          //     onInteractionStart: (details) {
          //       print("onInteractionStart----" + details.toString());
          //     },
          //     onInteractionEnd: (details) {
          //       print("onInteractionEnd----" + details.toString());
          //     },
          //     onInteractionUpdate: (details) {
          //       print("onInteractionUpdate----" + details.toString());
          //     },
          //     child: Hero(
          //       tag: "post_image_${widget.defaultImage}",
          //       child: ImageHelper.imageNetwork(
          //         imageUrl: widget.galleryItems[widget.defaultImage],
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            ///布局自己换
            right: 15.0,
            top: viewPadding.top + 7.0,
            child: Text(
              '$tempSelect/${widget.galleryItems.length}',
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                color: ColorUtil.hexColor(0xffffff),
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Positioned(
            left: 15.0,
            top: viewPadding.top + 12.0,
            child: InkWell(
              child: Icon(
                Icons.close,
                color: ColorUtil.hexColor(0xffffff),
                size: 25.0,
              ),
              onTap: () {
                OneContext().pop();
              },
            ),
          )
        ],
      ),
    );
  }
}

class PhotoLoading extends StatelessWidget {
  const PhotoLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          color: ColorUtil.hexColor(0x333333),
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomLoadingIndicator(),
          Text(
            "加载中...",
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              color: ColorUtil.hexColor(0xffffff),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
