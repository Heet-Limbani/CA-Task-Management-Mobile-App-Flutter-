class AddCustomInvoiceDataModel {
  String? id;
  String? text;

  AddCustomInvoiceDataModel({this.id, this.text});

  AddCustomInvoiceDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    return data;
  }
}