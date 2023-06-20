class ConfigurationModel {
  String? id;
  String? meta;
  String? send;
  String? message;

  ConfigurationModel({this.id, this.meta, this.send, this.message});

  ConfigurationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meta = json['meta'];
    send = json['send'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meta'] = this.meta;
    data['send'] = this.send;
    data['message'] = this.message;
    return data;
  }
}
