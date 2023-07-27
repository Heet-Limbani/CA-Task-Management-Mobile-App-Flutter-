class PerformanceReportDataModel {
  String? id;
  String? name;
  int? totalTask;
  int? completeTask;
  String? performance;

  PerformanceReportDataModel(
      {this.id,
      this.name,
      this.totalTask,
      this.completeTask,
      this.performance});

  PerformanceReportDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalTask = json['total_task'];
    completeTask = json['complete_task'];
    performance = json['performance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['total_task'] = this.totalTask;
    data['complete_task'] = this.completeTask;
    data['performance'] = this.performance;
    return data;
  }
}