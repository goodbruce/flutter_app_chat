import 'dart:ffi';

enum ChatInputBarShowType {
  inputBarShowIdle, // 默认
  inputBarShowKeyboard, // 显示系统键盘
  inputBarShowEmoji, // 显示表情panel
  inputBarShowMore, // 显示更多操作panel
  inputBarShowRecordAudio, // 显示录音
}

// 定义表情的高度
const double kEmojiPanelHeight = 256.0;
const double kMorePanelHeight = 236.0;

class ChatInputBarController {

  // 键盘是否是第一相应
  Function(bool isShouldFocus)? inputFocusChanged;

  // 底部键盘表情键盘、more操作panel动画
  Function? startBottomPanelAnimation;

  // 更新输入的bar的状态
  Function(ChatInputBarShowType oldShowType, ChatInputBarShowType newShowType)?
      updateInputBarType;

  // 更新输入的bar的状态
  Function(ChatInputBarShowType showType)? textFieldBarStatus;

  // 聊天界面是否需要手势
  Function(bool isNeedDismissPanelGesture)? chatContainerNeedDismissPanelGesture;

  // 列表滚动到底部
  Function? scrollToBottom;

  // 隐藏键盘键盘或者表情键盘
  Function? dismissChatInputPanel;

  // 发送消息
  Function? userSendMessage;
}
