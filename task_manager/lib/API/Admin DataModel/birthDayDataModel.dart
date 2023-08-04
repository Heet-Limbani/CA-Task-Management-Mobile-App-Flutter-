class BirthDayList {
  List<Birthday>? birthday;

  BirthDayList({
    this.birthday,
  });

  BirthDayList.fromJson(Map<String,dynamic> json) {
    if (json['birthday_list'] != null) {
      birthday = <Birthday>[];
      json['birthday_list'].forEach((v) {
        birthday!.add(new Birthday.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.birthday != null) {
      data['birthday_list'] =
          this.birthday!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Birthday {
  String? id;
  String? userId;
  String? metaKey;
  String? metaValue;
  String? userName;
  String? type;

  Birthday(
      {this.id,
      this.userId,
      this.metaKey,
      this.metaValue,
      this.userName,
      this.type});

  Birthday.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    metaKey = json['meta_key'];
    metaValue = json['meta_value'];
    userName = json['user_name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['meta_key'] = this.metaKey;
    data['meta_value'] = this.metaValue;
    data['user_name'] = this.userName;
    data['type'] = this.type;
    return data;
  }
}
