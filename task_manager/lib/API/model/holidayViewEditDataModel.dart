class HolidayViewEditDataModel {
  String? id;
  String? title;
  String? description;
  String? date;
  String? createdOn;
  String? showToUsers;
  String? dl;

  HolidayViewEditDataModel(
      {this.id,
      this.title,
      this.description,
      this.date,
      this.createdOn,
      this.showToUsers,
      this.dl});

  HolidayViewEditDataModel.fromJson(Map<String, dynamic> json) {
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