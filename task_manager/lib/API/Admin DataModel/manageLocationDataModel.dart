class ManageLocationDataModel {
	String? id;
	String? maxLimit;
	String? minLimit;
	String? sortTag;
	String? empDispatch;
	String? location;
	String? default1;
	String? dl;
	String? cnt;

	ManageLocationDataModel({this.id, this.maxLimit, this.minLimit, this.sortTag, this.empDispatch, this.location, this.default1, this.dl, this.cnt});

	ManageLocationDataModel.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		maxLimit = json['max_limit'];
		minLimit = json['min_limit'];
		sortTag = json['sort_tag'];
		empDispatch = json['emp_dispatch'];
		location = json['location'];
		default1 = json['default'];
		dl = json['dl'];
		cnt = json['cnt'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['max_limit'] = this.maxLimit;
		data['min_limit'] = this.minLimit;
		data['sort_tag'] = this.sortTag;
		data['emp_dispatch'] = this.empDispatch;
		data['location'] = this.location;
		data['default'] = this.default1;
		data['dl'] = this.dl;
		data['cnt'] = this.cnt;
		return data;
	}
}