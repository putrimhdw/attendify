import 'package:flutter/material.dart';

class ListAttendanceHistory extends StatelessWidget {
  const ListAttendanceHistory(
      {super.key, required this.date, required this.time, required this.type});

  final String date;
  final String time;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.history),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.apply(color: Theme.of(context).colorScheme.onSurface),
                ),
                Text(
                  time,
                  style: Theme.of(context).textTheme.labelSmall?.apply(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                )
              ],
            ),
            Spacer(),
            Text(
              type,
              style: Theme.of(context).textTheme.labelLarge?.apply(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
            )
          ],
        ),
        Divider(),
      ],
    );
  }
}
