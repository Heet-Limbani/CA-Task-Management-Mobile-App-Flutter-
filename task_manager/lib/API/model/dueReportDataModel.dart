class DueReportDataModel {
  String? name;
  String? mobile;
  int? ticket;
  int? invoice;
  int? total;

  DueReportDataModel({this.name, this.mobile, this.ticket, this.invoice, this.total});

  DueReportDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    ticket = json['ticket'];
    invoice = json['invoice'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['ticket'] = this.ticket;
    data['invoice'] = this.invoice;
    data['total'] = this.total;
    return data;
  }
}