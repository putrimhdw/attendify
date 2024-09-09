import 'package:attendify/app/data/model/user_related.dart';
import 'package:attendify/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<UserRelated>(
                        stream: controller.getUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Error"),
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data?.name ?? "-",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.apply(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                              Text(
                                snapshot.data?.job ?? "-",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          );
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Your Information",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                Theme.of(context).colorScheme.outlineVariant),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.ACCOUNT_SETTING);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.people_outline),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: Text("Account Settings")),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.chevron_right)
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Divider(),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.PASSWORD_SETTING);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.lock),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: Text("Password Settings")),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.chevron_right)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        width: Get.width,
                        child: FilledButton(
                            onPressed: controller.onLogout,
                            child: Text("Logout")))
                  ],
                ),
              ),
      ),
    );
  }
}
