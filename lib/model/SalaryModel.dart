
// To parse this JSON data, do
//
//     final salaryModel = salaryModelFromJson(jsonString);

import 'dart:convert';

SalaryModel salaryModelFromJson(String str) => SalaryModel.fromJson(json.decode(str));

String salaryModelToJson(SalaryModel data) => json.encode(data.toJson());

class SalaryModel {
  SalaryModel({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  List<Datum> data;

  factory SalaryModel.fromJson(Map<String, dynamic> json) => SalaryModel(
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
    this.month,
    this.ctc,
    this.netSalary,
    this.creditDate,
    this.status,
    this.deleted,
    this.date,
  });

  String id;
  String employeeId;
  String month;
  String ctc;
  String netSalary;
  DateTime creditDate;
  String status;
  String deleted;
  DateTime date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    employeeId: json["employee_id"],
    month: json["month"],
    ctc: json["ctc"],
    netSalary: json["net_salary"],
    creditDate: DateTime.parse(json["credit_date"]),
    status: json["status"],
    deleted: json["deleted"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    "month": month,
    "ctc": ctc,
    "net_salary": netSalary,
    "credit_date": creditDate.toIso8601String(),
    "status": status,
    "deleted": deleted,
    "date": date.toIso8601String(),
  };
}