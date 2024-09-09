import 'package:flutter/material.dart';

class ListRequest extends StatelessWidget {
  const ListRequest(
      {super.key,
      required this.date,
      required this.status,
      required this.type});

  final String date;
  final int status;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(type == "Leave" ? Icons.time_to_leave : Icons.more_time),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            Text(
              status == 0
                  ? "Not Accepted"
                  : status == 2
                      ? "Accepted"
                      : "Pending",
              style: Theme.of(context).textTheme.labelLarge?.apply(
                    color: status == 0
                        ? Colors.red
                        : status == 2
                            ? Colors.green
                            : Colors.amber,
                  ),
            ),
          ],
        ),
        Divider()
      ],
    );
  }
}
