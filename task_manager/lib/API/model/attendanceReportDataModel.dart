class AttendanceReportDataModel {
  String? id;
  String? name;
  String? totalWork;
  int? totalLeave;
  int? totalDays;

  AttendanceReportDataModel({this.id, this.name, this.totalWork, this.totalLeave, this.totalDays});

  AttendanceReportDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalWork = json['total_work'];
    totalLeave = json['total_leave'];
    totalDays = json['total_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['total_work'] = this.totalWork;
    data['total_leave'] = this.totalLeave;
    data['total_days'] = this.totalDays;
    return data;
  }
}