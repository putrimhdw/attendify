import 'package:attendify/app/data/model/attend_status.dart';
import 'package:attendify/app/widgets/list_attendance_history.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {
  const AttendanceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: controller.onLogout, icon: Icon(Icons.logout)),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back,",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      StreamBuilder<String>(
                          stream: controller.getName(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return Text(
                              snapshot.data ?? "-",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            );
                          }),
                      SizedBox(
                        height: 25,
                      ),
                      StreamBuilder<AttendStatus>(
                          stream: controller.getLastStatus(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outlineVariant,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Last Status",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Your last status is ${snapshot.data?.type ?? "-"} on ",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        snapshot.data?.date ?? "-",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        snapshot.data?.time ?? "-",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton(
                            onPressed: controller.onCheckIn,
                            child: Text("Check In"),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          OutlinedButton(
                            onPressed: controller.onCheckOut,
                            child: Text("Check Out"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Attendance History")),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "See more",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                          )
                        ],
                      ),
                      StreamBuilder<List<AttendStatus>>(
                          stream: controller.getAttendLogs(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.data == null ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text("No Attend Takes"),
                              );
                            }
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text("Error"),
                              );
                            }

                            if (snapshot.data?.length == 0) {
                              return const Center(
                                child: Text("No Attend Takes"),
                              );
                            }
                            return ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ListAttendanceHistory(
                                  date: snapshot.data?[index].date ?? "-",
                                  time: snapshot.data?[index].time ?? "-",
                                  type: snapshot.data?[index].type ?? "-",
                                );
                              },
                              itemCount: snapshot.data?.length ?? 0,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 10,
                                );
                              },
                            );
                          }),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
