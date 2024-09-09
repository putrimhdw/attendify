import 'package:attendify/app/data/model/request_extra.dart';
import 'package:attendify/app/routes/app_pages.dart';
import 'package:attendify/app/widgets/list_request.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/request_controller.dart';

class RequestView extends GetView<RequestController> {
  const RequestView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.add),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  Get.toNamed(Routes.REQUEST_LEAVE);
                },
                child: Row(
                  children: [
                    Icon(Icons.time_to_leave),
                    SizedBox(
                      width: 12,
                    ),
                    Text("Leave"),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  Get.toNamed(Routes.REQUEST_OVERTIME);
                },
                child: Row(
                  children: [
                    Icon(Icons.more_time),
                    SizedBox(
                      width: 12,
                    ),
                    Text("Overtime"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Request",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: 25,
            ),
            StreamBuilder<List<RequestExtra>>(
                stream: controller.getRequestData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No Request Added"),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  }

                  if (snapshot.data?.length == 0) {
                    return const Center(
                      child: Text("No Request Added"),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListRequest(
                        date: snapshot.data?[index].date ?? "-",
                        status: snapshot.data?[index].status ?? 1,
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
    );
  }
}
