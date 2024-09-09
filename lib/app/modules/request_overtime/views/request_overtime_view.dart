import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/request_overtime_controller.dart';

class RequestOvertimeView extends GetView<RequestOvertimeController> {
  const RequestOvertimeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Overtime'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      readOnly: true,
                      controller: controller.dateController,
                      onTap: controller.selectDate,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month),
                        label: Text("Date"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: Get.width,
                      child: FilledButton(
                        onPressed: controller.onSubmitLeave,
                        child: Text("Send Request"),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
