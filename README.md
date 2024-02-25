# flutter_chat

flutter chat

## TODO
- [x] 消息多时被键盘挡住 (方式一：listview reverse: true，消息列表反着取。方式二：正向情况下scrollController.jumpTo(scrollController.position.maxScrollExtent)跳到最底部。)
- [] 与服务器断开连接后，如何手动重连(关闭应用在开启可以接收发送消息) 自动重连问题 (在服务器重启后,客户端自动重连 其他客户端发送消息收不到)
- [x] 消息在重连后推送到客户端
- [] 更多历史消息下拉拉取
- [] token过期
- [x] 好友发来消息 创建会话
- [x] 发送图片（图片保存本地 以及上传服务器）
- [x] 发送语音（同上）
- [x] minio私有策略 无法访问, 先放开
- [x] 群聊
- [] sqlite 单引号无法插入


#### 安卓模拟器有时候无法播放声音,需要重启模拟器才能播放
