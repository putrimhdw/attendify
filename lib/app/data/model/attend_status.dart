// To parse this JSON data, do
//
//     final attendStatus = attendStatusFromJson(jsonString);

import 'dart:convert';

AttendStatus attendStatusFromJson(String str) =>
    AttendStatus.fromJson(json.decode(str));

String attendStatusToJson(AttendStatus data) => json.encode(data.toJson());

class AttendStatus {
  String type;
  String date;
  String time;

  AttendStatus({
    required this.type,
    required this.date,
    required this.time,
  });

  factory AttendStatus.fromJson(Map<String, dynamic> json) => AttendStatus(
        type: json["type"],
        date: json["date"],
        time: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "date": date,
        "timestamp": time,
      };
}
