# flutter_chat

flutter chat

## TODO
- [x] 消息多时被键盘挡住 (方式一：listview reverse: true，消息列表反着取。方式二：正向情况下scrollController.jumpTo(scrollController.position.maxScrollExtent)跳到最底部。)
- [] 与服务器断开连接后，手动重连
- [x] 消息在重连后推送到客户端
- [] 消息历史消息下拉拉取
- [] token过期
- [] 好友发来消息 创建会话
- [] 发送图片（图片保存本地 以及上传服务器）
- [] 发送语音（同上）
