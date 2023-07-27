

import 'package:flutter/material.dart';

import '../../ui/Admin/DashBoard/homeAdmin.dart';

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

  DataRow getRow(
    SelectedCallBack callback,
    List<String> selectedIds,
    int index,
  ) {
    return DataRow(
      cells: [
        /* DataCell(Text(id.toString())),
        DataCell(Text(companyName)),
        DataCell(Text(firstName)),
        DataCell(Text(lastName)),
        DataCell(Text(phone)),*/
        DataCell(Text((index + 1).toString())),
        // DataCell(Text(id.toString())),
        DataCell(Text(client ?? "")),
        DataCell(Text(message ?? "")),
        DataCell(Text(description ?? "")),
        DataCell(Text(onDate.toString())),
        DataCell(Text(createdOn ?? "")),
      ],
      onSelectChanged: (newState) {
        callback(id.toString(), newState ?? false);
      },
      selected: selectedIds.contains(id.toString()),
    );
  }
}


// class Client {
//   String? id;
//   String? clientId;
//   String? message;
//   String? description;
//   String? onDate;
//   String? createdOn;
//   String? dl;
//   String? client;
//   Client(
//       {this.id,
//       this.clientId,
//       this.message,
//       this.description,
//       this.onDate,
//       this.createdOn,
//       this.dl,
//       this.client});
//   Client.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     clientId = json['client_id'];
//     message = json['message'];
//     description = json['description'];
//     onDate = json['on_date'];
//     createdOn = json['created_on'];
//     dl = json['dl'];
//     client = json['client'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['client_id'] = this.clientId;
//     data['message'] = this.message;
//     data['description'] = this.description;
//     data['on_date'] = this.onDate;
//     data['created_on'] = this.createdOn;
//     data['dl'] = this.dl;
//     data['client'] = this.client;
//     return data;
//   }
// }


