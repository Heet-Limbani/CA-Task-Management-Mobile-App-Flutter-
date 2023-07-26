class EmployeeLeaveDataModel {
  String? id;
  String? userId;
  String? reason;
  String? createdOn;
  String? fromDate;
  String? shift;
  String? toDate;
  String? fromTime;
  String? toTime;
  String? description;
  String? status;
  String? dl;
  String? userName;

  EmployeeLeaveDataModel(
      {this.id,
      this.userId,
      this.reason,
      this.createdOn,
      this.fromDate,
      this.shift,
      this.toDate,
      this.fromTime,
      this.toTime,
      this.description,
      this.status,
      this.dl,
      this.userName});

  EmployeeLeaveDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    reason = json['reason'];
    createdOn = json['created_on'];
    fromDate = json['from_date'];
    shift = json['shift'];
    toDate = json['to_date'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    description = json['description'];
    status = json['status'];
    dl = json['dl'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['reason'] = this.reason;
    data['created_on'] = this.createdOn;
    data['from_date'] = this.fromDate;
    data['shift'] = this.shift;
    data['to_date'] = this.toDate;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['description'] = this.description;
    data['status'] = this.status;
    data['dl'] = this.dl;
    data['user_name'] = this.userName;
    return data;
  }
}