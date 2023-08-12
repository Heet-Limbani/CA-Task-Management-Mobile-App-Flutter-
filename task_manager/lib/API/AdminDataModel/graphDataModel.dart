class GraphDataModel {
  String? month;
  String? complete;
  String? totalTask;

  GraphDataModel({this.month, this.complete, this.totalTask});

  GraphDataModel.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    complete = json['complete'];
    totalTask = json['total_task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['complete'] = this.complete;
    data['total_task'] = this.totalTask;
    return data;
  }
}