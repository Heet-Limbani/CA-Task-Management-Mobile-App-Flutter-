class AttendanceLogDataModel {
  String? id;
  String? userId;
  String? inTime;
  String? outTime;
  String? createdOn;
  String? createdBy;
  String? dl;
  String? userName;

  AttendanceLogDataModel(
      {this.id,
      this.userId,
      this.inTime,
      this.outTime,
      this.createdOn,
      this.createdBy,
      this.dl,
      this.userName});

  AttendanceLogDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    inTime = json['in_time'];
    outTime = json['out_time'];
    createdOn = json['created_on'];
    createdBy = json['created_by'];
    dl = json['dl'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['in_time'] = this.inTime;
    data['out_time'] = this.outTime;
    data['created_on'] = this.createdOn;
    data['created_by'] = this.createdBy;
    data['dl'] = this.dl;
    data['user_name'] = this.userName;
    return data;
  }
}