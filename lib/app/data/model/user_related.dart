// To parse this JSON data, do
//
//     final userRelated = userRelatedFromJson(jsonString);

import 'dart:convert';

UserRelated userRelatedFromJson(String str) => UserRelated.fromJson(json.decode(str));

String userRelatedToJson(UserRelated data) => json.encode(data.toJson());

class UserRelated {
    String name;
    String job;
    String email;

    UserRelated({
        required this.name,
        required this.job,
        required this.email,
    });

    factory UserRelated.fromJson(Map<String, dynamic> json) => UserRelated(
        name: json["name"],
        job: json["job"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "job": job,
        "email": email,
    };
}
