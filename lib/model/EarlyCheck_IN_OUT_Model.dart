// To parse this JSON data, do
//
//     final earlyCheckInOutModel = earlyCheckInOutModelFromJson(jsonString);

import 'dart:convert';

EarlyCheckInOutModel earlyCheckInOutModelFromJson(String str) => EarlyCheckInOutModel.fromJson(json.decode(str));

String earlyCheckInOutModelToJson(EarlyCheckInOutModel data) => json.encode(data.toJson());

class EarlyCheckInOutModel {
  EarlyCheckInOutModel({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  List<Datum> data;

  factory EarlyCheckInOutModel.fromJson(Map<String, dynamic> json) => EarlyCheckInOutModel(
    status: json["status"],
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.employeeId,
    this.status,
    this.deleted,
    this.date,
    this.reasion,
  });

  String id;
  String employeeId;
  String status;
  String deleted;
  String date;
  String reasion;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    employeeId: json["employee_id"],
    status: json["status"],
    deleted: json["deleted"],
    date: json["date"],
    reasion: json["reasion"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    "status": status,
    "deleted": deleted,
    "date": date,
    "reasion": reasion,
  };
}