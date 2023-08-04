class LoginData {
  String? iD;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? password;
  String? token;
  String? avatar;
  String? active;
  String? onlineTimestamp;
  String? sessionTime;
  String? type;
  String? contactNumber;
  String? permission;
  String? xtoken;

  LoginData(
      {this.iD,
      this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.password,
      this.token,
      this.avatar,
      this.active,
      this.onlineTimestamp,
      this.sessionTime,
      this.type,
      this.contactNumber,
      this.permission,
      this.xtoken});

  LoginData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    token = json['token'];
    avatar = json['avatar'];
    active = json['active'];
    onlineTimestamp = json['online_timestamp'];
    sessionTime = json['session_time'];
    type = json['type'];
    contactNumber = json['contact_number'];
    permission = json['permission'];
    xtoken = json['Xtoken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['token'] = this.token;
    data['avatar'] = this.avatar;
    data['active'] = this.active;
    data['online_timestamp'] = this.onlineTimestamp;
    data['session_time'] = this.sessionTime;
    data['type'] = this.type;
    data['contact_number'] = this.contactNumber;
    data['permission'] = this.permission;
    data['Xtoken'] = this.xtoken;
    return data;
  }
}