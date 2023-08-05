class ClientManualPaymentDataModel {
  String? id;
  String? clientId;
  String? title;
  String? amount;
  String? description;
  String? image;
  String? createdOn;
  String? clientFirstName;
  String? clientLastName;

  ClientManualPaymentDataModel(
      {this.id,
      this.clientId,
      this.title,
      this.amount,
      this.description,
      this.image,
      this.createdOn,
      this.clientFirstName,
      this.clientLastName});

  ClientManualPaymentDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    title = json['title'];
    amount = json['amount'];
    description = json['description'];
    image = json['image'];
    createdOn = json['created_on'];
    clientFirstName = json['client_first_name'];
    clientLastName = json['client_last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_on'] = this.createdOn;
    data['client_first_name'] = this.clientFirstName;
    data['client_last_name'] = this.clientLastName;
    return data;
  }
}