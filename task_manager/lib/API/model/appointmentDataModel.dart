class AppointmentDataModel {
  String? id;
  String? clientId;
  String? createdOn;
  String? date;
  String? time;
  String? description;
  String? topic;
  String? status;
  String? dl;
  String? userName;

  AppointmentDataModel(
      {this.id,
      this.clientId,
      this.createdOn,
      this.date,
      this.time,
      this.description,
      this.topic,
      this.status,
      this.dl,
      this.userName});

  AppointmentDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['Client_id'];
    createdOn = json['created_on'];
    date = json['date'];
    time = json['time'];
    description = json['description'];
    topic = json['topic'];
    status = json['status'];
    dl = json['dl'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Client_id'] = this.clientId;
    data['created_on'] = this.createdOn;
    data['date'] = this.date;
    data['time'] = this.time;
    data['description'] = this.description;
    data['topic'] = this.topic;
    data['status'] = this.status;
    data['dl'] = this.dl;
    data['user_name'] = this.userName;
    return data;
  }
}