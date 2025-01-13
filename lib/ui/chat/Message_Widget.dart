import 'package:chatnow/Shared_Data.dart';
import 'package:chatnow/model/Message.dart';
import 'package:chatnow/utils/Date_Format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageWidget extends StatelessWidget {
  Message message;

  MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return message.senderId == SharedData.user?.id
        ? SentMessage(message.dateTime!, message.content!)
        : RecievedMessage(
            message.dateTime!, message.content!, message.senderName!);
  }
}

class SentMessage extends StatelessWidget {
  int dateTime;
  String content;

  SentMessage(this.dateTime, this.content);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color(0xff3598DB),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24),
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24))),
          child: Text(
            content,
            style: GoogleFonts.openSans(fontSize: 14, color: Colors.white),
          ),
        ),
        Text(
          '${formatMessageDate(dateTime)}',
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}

class RecievedMessage extends StatelessWidget {
  String senderName;
  int dateTime;
  String content;

  RecievedMessage(this.dateTime, this.content, this.senderName);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          senderName,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 12,
                  color: Color(0xff7F7F7F),
                  fontWeight: FontWeight.w500)),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color(0xffF8F8F8),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24),
                  topLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24))),
          child: Text(
            content,
            style: GoogleFonts.openSans(fontSize: 14, color: Color(0xff787993)),
          ),
        ),
        Text(
          '${formatMessageDate(dateTime)}',
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}
