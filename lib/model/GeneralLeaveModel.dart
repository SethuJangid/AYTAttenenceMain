// To parse this JSON data, do
//
//     final generalLeaveModel = generalLeaveModelFromJson(jsonString);

import 'dart:convert';

GeneralLeaveModel generalLeaveModelFromJson(String str) => GeneralLeaveModel.fromJson(json.decode(str));

String generalLeaveModelToJson(GeneralLeaveModel data) => json.encode(data.toJson());

class GeneralLeaveModel {
  GeneralLeaveModel({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  List<Datum> data;

  factory GeneralLeaveModel.fromJson(Map<String, dynamic> json) => GeneralLeaveModel(
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
    this.name,
    this.leaveDate,
    this.status,
    this.deleted,
    this.date,
  });

  String id;
  String name;
  String leaveDate;
  String status;
  String deleted;
  String date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    leaveDate: json["leave_date"] == null ? null : json["leave_date"],
    status: json["status"] == null ? null : json["status"],
    deleted: json["deleted"] == null ? null : json["deleted"],
    date: json["date"] == null ? null : json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "leave_date": leaveDate == null ? null : leaveDate,
    "status": status == null ? null : status,
    "deleted": deleted == null ? null : deleted,
    "date": date == null ? null : date,
  };
}
