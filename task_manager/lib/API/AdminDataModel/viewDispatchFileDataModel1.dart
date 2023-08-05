class ViewDispatchFileDataModel1 {
  List<File>? file;
  String? fromdate;
  String? todate;

  ViewDispatchFileDataModel1({this.file, this.fromdate, this.todate});

  ViewDispatchFileDataModel1.fromJson(Map<String, dynamic> json) {
    if (json['file'] != null) {
      file = <File>[];
      json['file'].forEach((v) {
        file!.add(new File.fromJson(v));
      });
    }
    fromdate = json['fromdate'];
    todate = json['todate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.file != null) {
      data['file'] = this.file!.map((v) => v.toJson()).toList();
    }
    data['fromdate'] = this.fromdate;
    data['todate'] = this.todate;
    return data;
  }
}

class File {
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
  String? location;
  String? cname;
  String? outBy;

  File(
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
      this.location,
      this.cname,
      this.outBy});

  File.fromJson(Map<String, dynamic> json) {
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
    location = json['location'];
    cname = json['cname'];
    outBy = json['out_by'];
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
    data['location'] = this.location;
    data['cname'] = this.cname;
    data['out_by'] = this.outBy;
    return data;
  }
}