import 'package:flutter/material.dart';
import 'package:flutter_app_chat/utils/color_util.dart';

class DialogItem {
  String? title;
  String? color;

  DialogItem({this.title, this.color});
}

class ShowAlertDialog extends StatefulWidget {
  const ShowAlertDialog({
    Key? key,
    this.contentAlign = TextAlign.left,
    required this.onTap,
    this.itemTitles,
    this.content,
    this.title,
    this.children,
  }) : super(key: key);

  // 内容区域布局
  final TextAlign contentAlign;

  final String? title;

  final String? content;

  // 点击返回index 0 1
  final Function onTap;

  //按钮
  final List<DialogItem>? itemTitles;

  final List<Widget>? children;

  @override
  State<ShowAlertDialog> createState() => _ShowAlertDialogState();
}

class _ShowAlertDialogState extends State<ShowAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        // ClipRRect 创建圆角矩形 要不然发现下边button不是圆角
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Container(
            color: Color(0xFFFFFFFF),
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                _buildTitleWidget(),
                SizedBox(
                  height: (_hasTitleAndContent() ? 10.0 : 0.0),
                ),
                _buildContentWidget(),
                SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFf5f5f5),
                        width: 1,
                      ),
                    ),
                  ),
                ),
                _buildItemWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _hasTitle() {
    if (widget.title != null && widget.title!.isNotEmpty) {
      return true;
    }

    return false;
  }

  bool _hasContent() {
    if (widget.content != null && widget.content!.isNotEmpty) {
      return true;
    }

    return false;
  }

  bool _hasTitleAndContent() {
    if (_hasTitle() && _hasContent()) {
      return true;
    }
    return false;
  }

  Widget _buildTitleWidget() {
    bool aHasTitle = _hasTitle();
    if (aHasTitle) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          "${widget.title}",
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            color: Color(0xFF1A1A1A),
            decoration: TextDecoration.none,
          ),
        ),
      );
    }

    return Container();
  }

  Widget _buildContentWidget() {
    bool aHasContent = _hasContent();
    if (aHasContent) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          "${widget.content}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            color: Color(0xFF333333),
            decoration: TextDecoration.none,
          ),
        ),
      );
    }

    return Container();
  }

  Widget _buildItemWidget() {
    if (widget.children != null && widget.children!.isNotEmpty) {
      return Container(
        height: 44.0,
        child: Row(
          children: widget.children!.map((res) {
            int index = widget.children!.indexOf(res);
            return Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  widget.onTap(index);
                },
                child: Container(
                  height: 44,
                  alignment: Alignment.center,
                  child: res,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Color(0xFFF5F5F5),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    }

    if (widget.itemTitles != null && widget.itemTitles!.isNotEmpty) {
      return Container(
        height: 44,
        child: Row(
          children: widget.itemTitles!.map((res) {
            int index = widget.itemTitles!.indexOf(res);
            return buildItem(res, index);
          }).toList(),
        ),
      );
    }

    return Container();
  }

  Widget buildItem(DialogItem item, int index) {
    String? title = item.title;
    String? color = item.color;
    Color textColor = ColorUtil.hexColor(0x333333);
    if (color != null && color.isNotEmpty) {
      textColor = ColorUtil.hexColorString(color);
    }
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          widget.onTap(index);
        },
        child: Container(
          height: 44,
          alignment: Alignment.center,
          child: Text(
            "${title}",
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          ),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Color(0xFFF5F5F5),
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
