import 'package:chatnow/database/My_Database.dart';
import 'package:chatnow/model/Room.dart';
import 'package:chatnow/ui/base/Base.dart';

abstract class HomeNavigator extends BaseNavigator {}

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List<Room> rooms = [];

  void loadRooms() async {
    rooms = await MyDatabase.loadRooms();
    notifyListeners();
  }
}
