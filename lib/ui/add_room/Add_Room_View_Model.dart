import 'package:chatnow/database/My_Database.dart';
import 'package:chatnow/model/Room.dart';
import 'package:chatnow/ui/base/Base.dart';
import 'package:flutter/cupertino.dart';

abstract class AddRoomNavigator extends BaseNavigator {}

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void addRoom(String title, String desc, String catId, context) async {
    navigator?.showLoading(message: 'creating room....');
    try {
      var res = await MyDatabase.createRoom(Room(
        title: title,
        description: desc,
        catId: catId,
      ));
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog(
        'Room Created Successfully',
        postActionName: 'Ok',
        postAction: () {
          Navigator.pop(context);
        },
      );
    } catch (e) {
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog('something went wrong ${e.toString()}',
          negActionName: 'Ok');
    }
  }
}
