import 'package:flutter/material.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/common_widget/show_alert_dialog.dart';

class ShowSheetDialog extends StatefulWidget {
  const ShowSheetDialog({
    Key? key,
    required this.onTap,
    required this.items,
    required this.title,
  }) : super(key: key);

  //按钮title
  final List<DialogItem> items;

  //点击事件回调 0开始
  final Function onTap;

  //标题 可选
  final String title;

  @override
  State<ShowSheetDialog> createState() => _ShowSheetDialogState();
}

class _ShowSheetDialogState extends State<ShowSheetDialog> {
  @override
  Widget build(BuildContext context) {
    double viewPaddingBottom = MediaQuery.of(context).viewPadding.bottom;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
      child: Container(
        color: ColorUtil.hexColor(0xf7f7f7),
        padding: EdgeInsets.only(bottom: viewPaddingBottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _itemTitle(context),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.items.map((item) {
                int index = widget.items.indexOf(item);
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    if (widget.onTap != null) {
                      widget.onTap(index);
                    }
                  },
                  child: _itemCreate(item),
                );
              }).toList(),
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: _itemCreate(DialogItem(title: "取消", color: "333333")),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _itemTitle(BuildContext context) {
    //有标题的情况下
    if (widget.title != null && widget.title.isNotEmpty) {
      return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: Text(
          "${widget.title}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            color: ColorUtil.hexColor(0x777777),
            decoration: TextDecoration.none,
          ),
        ),
      );
    }

    return Container();
  }

  Widget _itemCreate(DialogItem item) {
    String title = item.title ?? "";
    String? color = item.color;
    Color textColor = ColorUtil.hexColor(0x333333);
    if (color != null && color.isNotEmpty) {
      textColor = ColorUtil.hexColorString(color);
    }

    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          "${title}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            color: textColor,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: ColorUtil.hexColor(0xf7f7f7),
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
