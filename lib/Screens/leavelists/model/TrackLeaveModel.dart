// To parse this JSON data, do
//
//     final trackLeaveModel = trackLeaveModelFromJson(jsonString);

import 'dart:convert';

TrackLeaveModel trackLeaveModelFromJson(String str) => TrackLeaveModel.fromJson(json.decode(str));

String trackLeaveModelToJson(TrackLeaveModel data) => json.encode(data.toJson());

class TrackLeaveModel {
  TrackLeaveModel({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  List<Datum> data;

  factory TrackLeaveModel.fromJson(Map<String, dynamic> json) => TrackLeaveModel(
    status: json["status"] == null ? null : json["status"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.employeeId,
    this.leaveTypeId,
    this.fromDate,
    this.toDate,
    this.reason,
    this.status,
    this.deleted,
    this.date,
    this.halfDay,
    this.name,
  });

  String id;
  String employeeId;
  String leaveTypeId;
  String fromDate;
  String toDate;
  String reason;
  String status;
  String deleted;
  String date;
  String halfDay;
  String name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    employeeId: json["employee_id"] == null ? null : json["employee_id"],
    leaveTypeId: json["leave_type_id"] == null ? null : json["leave_type_id"],
    fromDate: json["from_date"] == null ? null : json["from_date"],
    toDate: json["to_date"] == null ? null : json["to_date"],
    reason: json["reason"] == null ? null : json["reason"],
    status: json["status"] == null ? null : json["status"],
    deleted: json["deleted"] == null ? null : json["deleted"],
    date: json["date"] == null ? null : json["date"],
    halfDay: json["half_day"] == null ? null : json["half_day"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "employee_id": employeeId == null ? null : employeeId,
    "leave_type_id": leaveTypeId == null ? null : leaveTypeId,
    "from_date": fromDate == null ? null : fromDate,
    "to_date": toDate == null ? null : toDate,
    "reason": reason == null ? null : reason,
    "status": status == null ? null : status,
    "deleted": deleted == null ? null : deleted,
    "date": date == null ? null : date,
    "half_day": halfDay == null ? null : halfDay,
    "name": name == null ? null : name,
  };
}
