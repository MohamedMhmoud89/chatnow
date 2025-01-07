import 'package:chatnow/Shared_Data.dart';
import 'package:chatnow/database/My_Database.dart';
import 'package:chatnow/model/Message.dart';
import 'package:chatnow/model/Room.dart';
import 'package:chatnow/ui/base/Base.dart';

abstract class ChatThreadNavigator extends BaseNavigator {
  void clearMessageText();
}

class ChatThreadViewModel extends BaseViewModel<ChatThreadNavigator> {
  late Room room;

  void send(String messageContent) {
    if (messageContent.trim().isEmpty) return;
    var message = Message(
      content: messageContent,
      dateTime: DateTime.now().millisecondsSinceEpoch,
      senderId: SharedData.user?.id,
      senderName: SharedData.user?.userName,
      roomId: room.id,
    );
    MyDatabase.sendMessage(room.id ?? '', message).then(
      (value) {
        navigator?.clearMessageText();
      },
    ).onError(
      (error, stackTrace) {
        navigator?.showMessageDialog(
          'something went wrong',
          postActionName: 'Try again',
          postAction: () => send(messageContent),
          negActionName: 'Cancel',
        );
      },
    );
  }
}
