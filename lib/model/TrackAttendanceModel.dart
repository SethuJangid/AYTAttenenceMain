// To parse this JSON data, do
//
//     final trackAttendanceModel = trackAttendanceModelFromJson(jsonString);

import 'dart:convert';

TrackAttendanceModel trackAttendanceModelFromJson(String str) => TrackAttendanceModel.fromJson(json.decode(str));

String trackAttendanceModelToJson(TrackAttendanceModel data) => json.encode(data.toJson());

class TrackAttendanceModel {
  TrackAttendanceModel({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  List<Datum> data;

  factory TrackAttendanceModel.fromJson(Map<String, dynamic> json) => TrackAttendanceModel(
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
    this.checkinTime,
    this.checkoutTime,
    this.lateCheckin,
    this.absent,
    this.lateCheckout,
    this.status,
    this.deleted,
    this.checkinFile,
    this.checkoutFile,
    this.device,
    this.earlyCheckout,
  });

  String id;
  String employeeId;
  String checkinTime;
  String checkoutTime;
  String lateCheckin;
  String absent;
  String lateCheckout;
  String status;
  String deleted;
  String checkinFile;
  String checkoutFile;
  String device;
  String earlyCheckout;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    employeeId: json["employee_id"],
    checkinTime: json["checkin_time"],
    checkoutTime: json["checkout_time"],
    lateCheckin: json["late_checkin"],
    absent: json["absent"],
    lateCheckout: json["late_checkout"],
    status: json["status"],
    deleted: json["deleted"],
    checkinFile: json["checkin_file"],
    checkoutFile: json["checkout_file"],
    device: json["device"],
    earlyCheckout: json["early_checkout"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    "checkin_time": checkinTime,
    "checkout_time": checkoutTime,
    "late_checkin": lateCheckin,
    "absent": absent,
    "late_checkout": lateCheckout,
    "status": status,
    "deleted": deleted,
    "checkin_file": checkinFile,
    "checkout_file": checkoutFile,
    "device": device,
    "early_checkout": earlyCheckout,
  };
}
