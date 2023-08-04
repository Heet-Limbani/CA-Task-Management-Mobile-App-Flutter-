class HolidayList {
  List<Holiday>? holiday;

  HolidayList({
    this.holiday,
  });

  HolidayList.fromJson(Map<String, dynamic> json) {
    if (json['holiday'] != null) {
      holiday = <Holiday>[];
      json['holiday'].forEach((v) {
        holiday!.add(new Holiday.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
     if (this.holiday != null) {
      data['holiday'] = this.holiday!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Holiday {
  String? id;
  String? title;
  String? description;
  String? date;
  String? createdOn;
  String? showToUsers;
  String? dl;


  Holiday(
       {this.id,
      this.title,
      this.description,
      this.date,
      this.createdOn,
      this.showToUsers,
      this.dl});

  Holiday.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    createdOn = json['created_on'];
    showToUsers = json['show_to_users'];
    dl = json['dl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;
    data['created_on'] = this.createdOn;
    data['show_to_users'] = this.showToUsers;
    data['dl'] = this.dl;
    return data;
  }
}
