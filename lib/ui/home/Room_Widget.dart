import 'package:chatnow/model/Room.dart';
import 'package:chatnow/ui/chat/Chat_Thread.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoomWidget extends StatelessWidget {
  Room room;

  RoomWidget(this.room);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ChatThread.routeName, arguments: room);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Color(0xff30303033),
                  blurRadius: 15,
                  offset: Offset(0, 5))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/${room.catId}.png',
              width: 86,
              height: 86,
            ),
            Text(
              "${room.title}",
              style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}
