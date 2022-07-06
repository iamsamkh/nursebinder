import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nurse_binder/constant.dart';
import 'package:nurse_binder/screens/booking/booking.dart';
import 'package:nurse_binder/screens/booking/pages/chat_bubble.dart';

class ChatScreen extends GetView<BookingController> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    final _userId = FirebaseAuth.instance.currentUser!.uid;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: KSecondaryColor,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(right: 15),
                      leading: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () => Get.back<dynamic>(),
                              child: Image.asset(
                                "assets/arrow-left.png",
                                height: 20,
                                color: KWhiteColor,
                              ),
                            ),
                            SizedBox(
                                height: 52,
                                width: 52,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                imageUrl: controller.nurseInfo
                                    !.imgUrl,
                                fit: BoxFit.cover,
                                errorWidget: (context, error, _) {
                                  return const Icon(Icons.error);
                                },
                              ))),
                          ],
                        ),
                      ),
                      title: Text(
                        controller.nurseInfo!.nurseTitle,
                        style: whiteSimpleText,
                      ),
                      subtitle: Text(
                        controller.nurseInfo!.nurseType,
                        style: WhiteMsg,
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                            controller.makePhoneCall();
                            },
                        child: Image.asset(
                          "assets/Vector - 2022-03-20T174436.734.png",
                          height: 16.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.74,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore
                            .collection('bookings')
                            .doc(controller.bookingId)
                            .collection('chat').orderBy('time')
                            .snapshots(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                                child: Text('Unknown Error Occurred'));
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                                child: Text('no messages yet..'));
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final messagesDocs = snapshot.data!.docs;
                          if (messagesDocs.isEmpty) {
                            return const Center(
                                child: Text('no messages yet..'));
                          }
                          return ListView.builder(
                              itemCount: messagesDocs.length,
                              itemBuilder: (context, index) {
                                return ChatBubble(
                                    msg: messagesDocs[index]['text'],
                                    time: messagesDocs[index]['time'],
                                    isMe: messagesDocs[index]['senderId'] ==
                                            _userId
                                        ? true
                                        : false);
                              });
                        }))
                    // child: ListView(
                    //   children: [
                    //     Column(
                    //       children: [
                    //         SizedBox(
                    //           height: 10.h,
                    //         ),
                    //         Text(
                    //           "Wednesday, 19 April, 2021",
                    //           style: paragraphText,
                    //         ),
                    //         ChatBubble(
                    //           msg:
                    //               "I’m on the way, will reach there in about 5 mins",
                    //           time: Timestamp.now(),
                    //           isMe: false,
                    //         ),
                    //         ChatBubble(
                    //           msg:
                    //               "Just to confirm, You’re Registered Nurse right ?",
                    //           time: Timestamp.now(),
                    //           isMe: true,
                    //         ),
                    //         ChatBubble(
                    //           msg:
                    //               "I’m on the way, will reach there in about 5 mins",
                    //           time: Timestamp.now(),
                    //           isMe: false,
                    //         ),
                    //       ],
                    //     )
                    //   ],
                    // ),
                    ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 5,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  height: 80,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Get.width * 0.75,
                            color: KWhiteLightColor,
                            child: TextField(
                              controller: controller.textController,
                              style: headingSmallGrey,
                              cursorColor: KGreyColor,
                              decoration: InputDecoration(
                                fillColor: KWhiteLightColor,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 18.h, horizontal: 23),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: KWhiteLightColor,
                                  ),
                                ),
                                hintText: "Write message for ${controller.nurseInfo!.nurseTitle}...",
                                hintStyle: GreyLightTextStyle,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9),
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: KSecondaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Obx(() => controller.sendingText.value ? const CircularProgressIndicator() : 
                               GestureDetector(
                            onTap: () {
                              controller.sendText();
                            },
                            child: Container(
                              height: 50,
                              width: Get.width * 0.15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: KSecondaryColor,
                              ),
                              child: const Icon(Icons.send, color: KWhiteColor,),
                            )
                          ),),
                          
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
