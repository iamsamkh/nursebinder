import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nurse_binder/screens/home/home.dart';
import 'package:nurse_binder/screens/home/pages/nurse_info_detail.dart';

import '../../../../constant.dart';
import '../../../widget/find_nurse_card.dart';

class FindNurse extends GetView<HomeController> {
  FindNurse({ Key? key }) : super(key: key);

  final arg = Get.arguments;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KPrimaryColor,
        elevation: 0,
        title: Text(
          "Registered Nurses",
          style: appBarHeading,
        ),
        centerTitle: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                "assets/arrow-left.png",
                height: 24,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: KSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: SizedBox(
                    height: 25,
                    width: 25,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset("assets/locate icon (1).png"))),
                title: Obx(
                  () => Text(
                  controller.address.value,
                  style: textStyle,
                ),
                ),
                minLeadingWidth: -4,
                trailing: Image.asset(
                  "assets/Vector - 2022-03-16T223339.401.png",
                  height: 18,
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            GetX<HomeController>(
              builder: (homecontroller) {
                if(controller.nurseData.isEmpty){
                    return const CircularProgressIndicator();
                  }else{
                    return ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount:  controller.nurseData.length,
                itemBuilder: (context, index) {
                  if(controller.nurseData[index].nurseType == arg) {
                    return InkWell(
                    borderRadius: BorderRadius.circular(10),
                      onTap: ()async{
                        controller.currentNurseSelection = index;
                        controller.resetNurseInfoDetail();
                        controller.fetchNurseReviews(controller.nurseData[index].nurseId);  
                        await Get.showOverlay(asyncFunction: controller.fetchServerTime, loadingWidget: const Center(child: CircularProgressIndicator(),));
                        await Get.to(() => const NurseInfoDetail());
                      },
                      child: FindNurseCard(
                        displayUrl: controller.nurseData[index].imgUrl,
                        title: controller.nurseData[index].nurseTitle,
                        type: controller.nurseData[index].nurseType,
                        rating: controller.nurseData[index].rating['avgrating'],
                      ),
                  );
                  }
                   return const SizedBox(); 
                },
              );
                  }
              } 
            ),
          ],
        ),
      ),
  );
  }
}

