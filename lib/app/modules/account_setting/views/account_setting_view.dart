import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/account_setting_controller.dart';

class AccountSettingView extends GetView<AccountSettingController> {
  const AccountSettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          child: Column(
            children: [
              TextFormField(
                controller: controller.nameController,
                validator: controller.onNameValidation,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  label: Text("Name"),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.jobController,
                validator: controller.onJobValidation,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.work_outline),
                  label: Text("Job"),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: Get.width,
                child: FilledButton(
                  onPressed: controller.onUpdateAccount,
                  child: Text("Update Account"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
