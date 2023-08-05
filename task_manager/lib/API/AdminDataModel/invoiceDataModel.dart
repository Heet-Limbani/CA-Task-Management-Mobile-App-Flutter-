class InvoiceDataModel {
  String? id;
  String? invoiceNo;
  String? clientId;
  String? dateOf;
  String? total;
  String? otherDetails;
  String? paymentId;
  String? paymentStatus;
  String? privateDetails;
  String? customInvoice;
  String? dateOfCreate;
  String? dateOfUpdate;
  String? createdBy;
  String? company;

  InvoiceDataModel(
      {this.id,
      this.invoiceNo,
      this.clientId,
      this.dateOf,
      this.total,
      this.otherDetails,
      this.paymentId,
      this.paymentStatus,
      this.privateDetails,
      this.customInvoice,
      this.dateOfCreate,
      this.dateOfUpdate,
      this.createdBy,
      this.company});

  InvoiceDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNo = json['invoice_no'];
    clientId = json['client_id'];
    dateOf = json['date_of'];
    total = json['total'];
    otherDetails = json['other_details'];
    paymentId = json['payment_id'];
    paymentStatus = json['payment_status'];
    privateDetails = json['private_details'];
    customInvoice = json['custom_invoice'];
    dateOfCreate = json['date_of_create'];
    dateOfUpdate = json['date_of_update'];
    createdBy = json['created_by'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_no'] = this.invoiceNo;
    data['client_id'] = this.clientId;
    data['date_of'] = this.dateOf;
    data['total'] = this.total;
    data['other_details'] = this.otherDetails;
    data['payment_id'] = this.paymentId;
    data['payment_status'] = this.paymentStatus;
    data['private_details'] = this.privateDetails;
    data['custom_invoice'] = this.customInvoice;
    data['date_of_create'] = this.dateOfCreate;
    data['date_of_update'] = this.dateOfUpdate;
    data['created_by'] = this.createdBy;
    data['company'] = this.company;
    return data;
  }
}