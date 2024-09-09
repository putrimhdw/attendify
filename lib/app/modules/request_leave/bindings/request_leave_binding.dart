import 'package:get/get.dart';

import '../controllers/request_leave_controller.dart';

class RequestLeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestLeaveController>(
      () => RequestLeaveController(),
    );
  }
}
