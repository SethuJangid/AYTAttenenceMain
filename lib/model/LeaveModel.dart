import 'dart:convert';

LeaveModelData leaveModelDataFromJson(String str) => LeaveModelData.fromJson(json.decode(str));

String leaveModelDataToJson(LeaveModelData data) => json.encode(data.toJson());

class LeaveModelData {
  LeaveModelData({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  List<Datum> data;

  factory LeaveModelData.fromJson(Map<String, dynamic> json) => LeaveModelData(
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
    this.leaveId,
    this.leaveType,
    this.totalAllowd,
    this.totalUsed,
    this.totalUnused,
  });

  String leaveId;
  String leaveType;
  String totalAllowd;
  int totalUsed;
  int totalUnused;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    leaveId: json["leave_id"],
    leaveType: json["leave_type"],
    totalAllowd: json["total_allowd"],
    totalUsed: json["total_used"],
    totalUnused: json["total_unused"],
  );

  Map<String, dynamic> toJson() => {
    "leave_id": leaveId,
    "leave_type": leaveType,
    "total_allowd": totalAllowd,
    "total_used": totalUsed,
    "total_unused": totalUnused,
  };
}
