class genModel {
  bool? status;
  String? message;
  dynamic data;
  int? count;
  bool? logout;
  
  


  genModel({this.status,this.message, this.data, this.count, this.logout});

  genModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
    count = json['count'];
    logout = json['logout'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    data['count'] = this.count;
    data['logout'] = this.logout;
    
    return data;
  }
}


// class genModel {
//   bool? status;
//   String? message;
//   dynamic data;
//   bool? logout;

//   genModel({this.status, this.message, this.data, this.logout});

//   genModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'];
//     logout = json['logout'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     data['data'] = this.data;
//     data['logout'] = this.logout;
//     return data;
//   }
// }
