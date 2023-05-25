class Client {
  String? id;
  String? clientId;
  String? message;
  String? description;
  String? onDate;
  String? createdOn;
  String? dl;
  String? client;

  Client(
      {this.id,
      this.clientId,
      this.message,
      this.description,
      this.onDate,
      this.createdOn,
      this.dl,
      this.client});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    message = json['message'];
    description = json['description'];
    onDate = json['on_date'];
    createdOn = json['created_on'];
    dl = json['dl'];
    client = json['client'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['message'] = this.message;
    data['description'] = this.description;
    data['on_date'] = this.onDate;
    data['created_on'] = this.createdOn;
    data['dl'] = this.dl;
    data['client'] = this.client;
    return data;
  }
}