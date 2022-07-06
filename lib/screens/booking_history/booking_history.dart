import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse_binder/screens/booking_history/booking_history_controller.dart';
import 'package:nurse_binder/screens/booking_history/review_rating.dart';

import '../../constant.dart';
import '../../widget/booking_history_card.dart';

class BookingHistory extends GetView<BookingHistoryController> {
  const BookingHistory({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: KPrimaryColor,
        elevation: 0,
        title: Text(
          "Booking History",
          style: appBarHeading,
        ),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value ? const Center(child: CircularProgressIndicator()) : 
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Scrollbar(
            controller: controller.scrollController,
            
            child: ListView(
              controller: controller.scrollController,
              children: [
                GetBuilder<BookingHistoryController>(builder: ((con) =>ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: con.bookingsData.value.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async{
                          if(con.bookings[index].bookingStatus=='Completed'){
                            try{
                            await Get.showOverlay(asyncFunction: () async{
                            await controller.fetchReview(con.bookings[index].nurseId, con.bookings[index].bookingId);
                          },
                          loadingWidget: const Center(child: CircularProgressIndicator(),)
                          );
                            Get.to(() => const ReviewRating(), arguments: {'nurseId': con.bookings[index].nurseId, 'bookingId': con.bookings[index].bookingId}); 
                          } catch(c){
                            Get.showSnackbar(
                          const GetSnackBar(
                            message:
                                'Ops! Error occured while fetching review details..',
                            backgroundColor: KOrragneColor,
                            isDismissible: true,
                            duration: Duration(seconds: 2),
                          ),
                        );
                          }
                          } else{
                            Get.showSnackbar(
                          const GetSnackBar(
                            message:
                                'Order should must be Completed before you can review.',
                            backgroundColor: KOrragneColor,
                            isDismissible: true,
                            duration: Duration(seconds: 2),
                          ),
                        );
                          }
                          
                        },
                        child: BookingHistoryCard(
                          nurseImgUrl: con.nurses[con.bookings[index].nurseId]!.imgUrl,
                          nurseTitle: con.nurses[con.bookings[index].nurseId]!.nurseTitle,
                          nurseType: con.nurses[con.bookings[index].nurseId]!.nurseType,
                          date: con.bookings[index].appointmentTime.toDate(),
                          hourCount: con.bookings[index].hours,
                          orderStatus: con.bookings[index].orderStatus,
                        ),
                      );
                    },
                  )
                ),)
              ],
            ),
          ),
        ),
      ),
    ));
  }
}