class CompanyFileDataModel {
  String? id;
  String? locationId;
  String? locationNum;
  String? type;
  String? clientId;
  String? userId;
  String? name;
  String? inwardTime;
  String? outwardTime;
  String? showToClient;
  String? downloadable;
  String? dl;
  String? receiverName;
  String? note;
  String? outwardBy;
  String? downl0ad;
  String? download;

  CompanyFileDataModel(
      {this.id,
      this.locationId,
      this.locationNum,
      this.type,
      this.clientId,
      this.userId,
      this.name,
      this.inwardTime,
      this.outwardTime,
      this.showToClient,
      this.downloadable,
      this.dl,
      this.receiverName,
      this.note,
      this.outwardBy,
      this.downl0ad,
      this.download});

  CompanyFileDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationId = json['location_id'];
    locationNum = json['location_num'];
    type = json['type'];
    clientId = json['client_id'];
    userId = json['user_id'];
    name = json['name'];
    inwardTime = json['inward_time'];
    outwardTime = json['outward_time'];
    showToClient = json['show_to_client'];
    downloadable = json['downloadable'];
    dl = json['dl'];
    receiverName = json['receiver_name'];
    note = json['note'];
    outwardBy = json['outward_by'];
    downl0ad = json['downl0ad'];
    download = json['download'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location_id'] = this.locationId;
    data['location_num'] = this.locationNum;
    data['type'] = this.type;
    data['client_id'] = this.clientId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['inward_time'] = this.inwardTime;
    data['outward_time'] = this.outwardTime;
    data['show_to_client'] = this.showToClient;
    data['downloadable'] = this.downloadable;
    data['dl'] = this.dl;
    data['receiver_name'] = this.receiverName;
    data['note'] = this.note;
    data['outward_by'] = this.outwardBy;
    data['downl0ad'] = this.downl0ad;
    data['download'] = this.download;
    return data;
  }
}
