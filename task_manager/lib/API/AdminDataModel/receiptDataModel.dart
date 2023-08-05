class ReceiptDataModel {
  List<File>? file;
  String? fromdate;
  String? todate;

  ReceiptDataModel({this.file, this.fromdate, this.todate});

  ReceiptDataModel.fromJson(Map<String, dynamic> json) {
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
  String? paytmOrderId;
  String? amount;
  String? date;
  String? clientId;
  String? paymentMethod;
  String? status;
  String? referenceNumber;
  String? description;
  String? clientName;

  File(
      {this.id,
      this.paytmOrderId,
      this.amount,
      this.date,
      this.clientId,
      this.paymentMethod,
      this.status,
      this.referenceNumber,
      this.description,
      this.clientName});

  File.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paytmOrderId = json['paytm_order_id'];
    amount = json['amount'];
    date = json['date'];
    clientId = json['client_id'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    referenceNumber = json['reference_number'];
    description = json['description'];
    clientName = json['client_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['paytm_order_id'] = this.paytmOrderId;
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['client_id'] = this.clientId;
    data['payment_method'] = this.paymentMethod;
    data['status'] = this.status;
    data['reference_number'] = this.referenceNumber;
    data['description'] = this.description;
    data['client_name'] = this.clientName;
    return data;
  }
}