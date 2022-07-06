import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nurse_binder/constant.dart';
import 'package:nurse_binder/screens/home/home.dart';

class BottomBar extends GetView<HomeController> {
  const BottomBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Obx(() => controller.iconList[controller.currentindex.value]) , //destination scre
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 20.0,
        child: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            unselectedItemColor: controller.currentindex.value == 0 ? KGreyColor : KSecondaryColor,
            selectedItemColor: controller.currentindex.value == 0 ? KSecondaryColor : KGreyColor,
        
            showUnselectedLabels: true,
            currentIndex: 0,
            onTap: (index) {
             controller.currentindex.value = index;
            },
            items: [
              BottomNavigationBarItem(
                  label: "Home",
                  icon: Image.asset("assets/Vector - 2022-03-21T103829.216.png",
                      height: 20,
                      color: controller.currentindex.value == 0 ? KSecondaryColor : KGreyColor),
                  tooltip: "Home"),
              BottomNavigationBarItem(
                label: "Booking",
                tooltip: "Home",
                icon: Image.asset("assets/Vector - 2022-03-21T103837.945.png",
                    height: 20,
                    color: controller.currentindex.value == 1 ? KSecondaryColor : KGreyColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}