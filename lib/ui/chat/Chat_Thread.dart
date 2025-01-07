import 'package:chatnow/database/My_Database.dart';
import 'package:chatnow/model/Message.dart';
import 'package:chatnow/model/Room.dart';
import 'package:chatnow/ui/base/Base.dart';
import 'package:chatnow/ui/chat/Chat_Thread_View_Model.dart';
import 'package:chatnow/ui/chat/Message_Widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatThread extends StatefulWidget {
  static const String routeName = 'chat';

  @override
  State<ChatThread> createState() => _ChatThreadState();
}

class _ChatThreadState extends BaseState<ChatThread, ChatThreadViewModel>
    implements ChatThreadNavigator {
  late Room room;

  var messageController = TextEditingController();

  @override
  ChatThreadViewModel initViewModel() {
    return ChatThreadViewModel();
  }

  @override
  Widget build(BuildContext context) {
    room = ModalRoute.of(context)?.settings.arguments as Room;
    viewModel.room = room;
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
            title: Text("${room.title}"),
          ),
          body: Container(
            height: 680,
            padding: EdgeInsets.only(left: 16, right: 16, top: 23, bottom: 16),
            margin: EdgeInsets.only(left: 20, right: 20, top: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff3030301A),
                      blurRadius: 15,
                      spreadRadius: 0,
                      offset: Offset(0, 5))
                ]),
            child: Column(
              children: [
                Expanded(
                    child: StreamBuilder<QuerySnapshot<Message>>(
                  stream: MyDatabase.getMessageCollection(room.id ?? "")
                      .orderBy("dateTime", descending: true)
                      .snapshots(),
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
                    return ListView.separated(
                      reverse: true,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                      itemBuilder: (context, index) {
                        return MessageWidget(data![index]);
                      },
                      itemCount: data?.length ?? 0,
                    );
                  },
                )),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(2),
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xffA9A8A8),
                                style: BorderStyle.solid,
                                width: 1),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10))),
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff3598DB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          viewModel.send(messageController.text);
                        },
                        child: Row(
                          spacing: 5,
                          children: [
                            Text(
                              'Send',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 12),
                            ),
                            Image.asset('assets/images/send.png')
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void clearMessageText() {
    messageController.clear();
  }
}
