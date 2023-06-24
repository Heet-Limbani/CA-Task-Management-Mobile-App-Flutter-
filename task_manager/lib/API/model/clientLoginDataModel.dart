class Login {
  String? id;
  String? userId;
  String? type;
  String? loginTime;
  String? logoutTime;
  String? createdOn;
  String? userName;

  Login(
      {this.id,
      this.userId,
      this.type,
      this.loginTime,
      this.logoutTime,
      this.createdOn,
      this.userName});

  Login.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    loginTime = json['login_time'];
    logoutTime = json['logout_time'];
    createdOn = json['created_on'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['login_time'] = this.loginTime;
    data['logout_time'] = this.logoutTime;
    data['created_on'] = this.createdOn;
    data['user_name'] = this.userName;
    return data;
  }
}