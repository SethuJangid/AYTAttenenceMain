// To parse this JSON data, do
//
//     final designationmodel = designationmodelFromJson(jsonString);

import 'dart:convert';

Designationmodel designationmodelFromJson(String str) => Designationmodel.fromJson(json.decode(str));

String designationmodelToJson(Designationmodel data) => json.encode(data.toJson());

class Designationmodel {
  Designationmodel({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  Data data;

  factory Designationmodel.fromJson(Map<String, dynamic> json) => Designationmodel(
    status: json["status"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.leaveAllowd,
    this.casualLeave,
    this.sickLeave,
    this.employeeLeave,
    this.status,
    this.deleted,
    this.date,
  });

  String id;
  String name;
  String leaveAllowd;
  String casualLeave;
  String sickLeave;
  String employeeLeave;
  String status;
  String deleted;
  DateTime date;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    leaveAllowd: json["leave_allowd"],
    casualLeave: json["casual_leave"],
    sickLeave: json["sick_leave"],
    employeeLeave: json["employee_leave"],
    status: json["status"],
    deleted: json["deleted"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "leave_allowd": leaveAllowd,
    "casual_leave": casualLeave,
    "sick_leave": sickLeave,
    "employee_leave": employeeLeave,
    "status": status,
    "deleted": deleted,
    "date": date.toIso8601String(),
  };
}