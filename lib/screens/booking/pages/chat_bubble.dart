import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';

class ChatBubble extends StatelessWidget {
  final String msg;
  final Timestamp time;
  final bool isMe;
  const ChatBubble({ Key? key, required this.msg, required this.time, required this.isMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width * 0.8,
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              color: isMe ? KWhiteLightColor : KSecondaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: SizedBox(
              width: Get.width * 0.61,
              child: Row(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      msg,
                      style: isMe ? paragraphText : WhiteMsg,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
              SizedBox(
                width: 10.w,
              ),
              Text(
                DateFormat('H:mm').format(time.toDate()),
                style: const TextStyle(
                  color: KGreyColor,
                  fontSize: 11,
                ),
              ),
            ],
      ),
    );
  }
}