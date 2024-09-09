import 'package:get/get.dart';

import '../controllers/request_overtime_controller.dart';

class RequestOvertimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestOvertimeController>(
      () => RequestOvertimeController(),
    );
  }
}
