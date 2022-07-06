import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nurse_binder/screens/home/pages/personalized_profile.dart';
import 'package:nurse_binder/screens/home/pages/find_nurse.dart';
import 'package:nurse_binder/screens/screens.dart';

import '../../../constant.dart';
import '../../model/nurse_type_model.dart';
import '../../../widget/home_nurse_widget.dart';
import '../../widget/top_nurse_card.dart';
import '../../widget/upcoming_booking.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: ListView(
          children: [
            GetBuilder<UploadPhotoController>(
              id: 'home_view',
              builder: (control) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SizedBox(
                      height: 52,
                      width: 52,
                      child: InkWell(
                        onTap: () {
                          control.setControllerValues();
                          Get.to(() => const PersonalizedProfile(),
                              transition: Transition.leftToRight,);
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: control.currentUser == null &&
                                    control.auth!.photoURL == null
                                ? const CircularProgressIndicator()
                                : CachedNetworkImage(
                                    imageUrl: control.currentUser == null
                                        ? control.auth!.photoURL.toString()
                                        : control.currentUser!.imgUrl,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )),
                      )),
                  title: Text(
                    control.currentUser == null &&
                            control.auth!.displayName == null
                        ? 'loading...'
                        : control.currentUser == null
                            ? control.auth!.displayName.toString()
                            : control.currentUser!.fName,
                    style: headingSmallKBlackLight,
                  ),
                  subtitle: Text(
                    control.currentUser == null &&
                            control.auth!.displayName == null
                        ? 'loading...'
                        : control.currentUser == null
                            ? 'Click to add your Facility Type'
                            : control.currentUser!.fType,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: KGreyColor,
                        fontFamily: "Roboto"),
                  ),
                  trailing: GestureDetector(
                    onTap: () => FirebaseAuth.instance.signOut(),
                    child: const Icon(Icons.logout),
                  ),
                ),
              );
            }),
            SizedBox(
              height: 27.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text("Find Professional Healthcare Near You",
                  style: headingText),
            ),
            SizedBox(
              height: 18.h,
            ),
            SizedBox(
              height: Get.height * 0.3,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: nurseList.length,
                itemBuilder: (context, index) {
                  NurseTypeModel nurs = nurse[index];
                  return GestureDetector(
                      onTap: () {
                        Get.to(() => FindNurse(), arguments: nurs.title);
                      },
                      child: NurseTypeCard(
                        title: nurs.title,
                        img: nurs.img,
                      ));
                },
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Top Rated Healthcare near you",
                    style: headingText,
                  ),
                  GetX<HomeController>(
                    builder: (controller) {
                      if (controller.nurseData.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.nurseData.length > 5
                              ? 5
                              : controller.nurseData.length,
                          itemBuilder: (context, index) {
                            return TopNurseCard(
                              title: controller.nurseData[index].nurseTitle,
                              type: controller.nurseData[index].nurseType,
                              imgUrl: controller.nurseData[index].imgUrl,
                              rating: controller
                                  .nurseData[index].rating['avgrating'],
                            );
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Upcoming Booking",
                        style: headingText,
                      ),
                      const Text(
                        "See all",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: KSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.2,
              child: GetBuilder<HomeController>(
                id: 'upComingBooking',
                builder: (cont) {
                if (cont.upBooking.isEmpty && cont.isempty == false) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if(cont.upBooking.isEmpty && cont.isempty == true){
                  return Center(
                    child: Text('No Upcoming Booking', style: headingSmallGrey,),
                  );
                }
                else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cont.upBooking.length,
                      itemBuilder: (context, index) {
                        return UpcomeingBooking(
                          cont.upBooking[index]['nurseTitle'],
                          cont.upBooking[index]['nurseImgUrl'],
                          cont.upBooking[index]['nurseType'],
                          cont.upBooking[index]['appointmentTime'].toDate(),
                        );
                      },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
