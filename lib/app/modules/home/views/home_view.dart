import 'package:attendify/app/modules/attendance/bindings/attendance_binding.dart';
import 'package:attendify/app/modules/attendance/views/attendance_view.dart';
import 'package:attendify/app/modules/request/bindings/request_binding.dart';
import 'package:attendify/app/modules/request/views/request_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../profile/bindings/profile_binding.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (!controller.isAuth.value) {
        Get.offAllNamed(Routes.LOGIN);
      }
    });

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.tabIndex.value,
          onDestinationSelected: controller.changeTabIndex,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.schedule), label: "Attendance"),
            NavigationDestination(
                icon: Icon(Icons.edit_note), label: "Request"),
            NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: Routes.ATTENDANCE,
        onGenerateRoute: (settings) {
          if (settings.name == Routes.ATTENDANCE) {
            return GetPageRoute(
              routeName: Routes.ATTENDANCE,
              page: () => const AttendanceView(),
              binding: AttendanceBinding(),
            );
          }
          if (settings.name == Routes.REQUEST) {
            return GetPageRoute(
              routeName: Routes.REQUEST,
              page: () => const RequestView(),
              binding: RequestBinding(),
            );
          }
          if (settings.name == Routes.PROFILE) {
            return GetPageRoute(
              routeName: Routes.PROFILE,
              page: () => const ProfileView(),
              binding: ProfileBinding(),
            );
          }
          return null;
        },
      ),
    );
  }
}
