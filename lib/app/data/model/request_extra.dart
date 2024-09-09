// To parse this JSON data, do
//
//     final leave = leaveFromJson(jsonString);

import 'dart:convert';

RequestExtra leaveFromJson(String str) =>
    RequestExtra.fromJson(json.decode(str));

String leaveToJson(RequestExtra data) => json.encode(data.toJson());

class RequestExtra {
  String date;
  String reason;
  String type;
  int status;

  RequestExtra({
    required this.date,
    required this.reason,
    required this.type,
    this.status = 1,
  });

  factory RequestExtra.fromJson(Map<String, dynamic> json) => RequestExtra(
        date: json["date"],
        reason: json["reason"],
        type: json["type"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "reason": reason,
        "type": type,
        "status": status,
      };
}
