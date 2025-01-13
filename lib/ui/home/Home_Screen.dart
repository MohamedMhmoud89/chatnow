import 'package:chatnow/Shared_Data.dart';
import 'package:chatnow/database/My_Database.dart';
import 'package:chatnow/ui/add_room/Add_Room_Screen.dart';
import 'package:chatnow/ui/base/Base.dart';
import 'package:chatnow/ui/home/Home_View_Model.dart';
import 'package:chatnow/ui/home/Room_Widget.dart';
import 'package:chatnow/ui/login/Login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }

  @override
  void initState() {
    super.initState();
    viewModel.loadRooms();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/images/login_pattern.png'),
              fit: BoxFit.fill),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Chat Now'),
            actions: [
              IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    SharedData.user = null;
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                  },
                  icon: Icon(Icons.logout_rounded)),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.pushNamed(context, AddRoomScreen.routeName);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
          body: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: MyDatabase.getRoomCollection().snapshots(),
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.hasError) {
                          return Center(
                            child: Text('Something went wrong'),
                          );
                        } else if (asyncSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        var data = asyncSnapshot.data?.docs
                            .map((doc) => doc.data())
                            .toList();
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 40,
                                  mainAxisSpacing: 30),
                          itemBuilder: (context, index) {
                            return RoomWidget(data![index]);
                          },
                          itemCount: data?.length ?? 0,
                        );
                      },
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
