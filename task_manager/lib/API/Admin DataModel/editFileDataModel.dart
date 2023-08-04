
class EditFileDataModel {
	Data? data;
	List<ClientData>? clientData;
	List<Location>? location;

	EditFileDataModel({this.data, this.clientData, this.location});

	EditFileDataModel.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? new Data.fromJson(json['data']) : null;
		if (json['client_data'] != null) {
			clientData = <ClientData>[];
			json['client_data'].forEach((v) { clientData!.add(new ClientData.fromJson(v)); });
		}
		if (json['location'] != null) {
			location = <Location>[];
			json['location'].forEach((v) { location!.add(new Location.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
		if (this.clientData != null) {
      data['client_data'] = this.clientData!.map((v) => v.toJson()).toList();
    }
		if (this.location != null) {
      data['location'] = this.location!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Data {
	String? id;
	String? locationId;
	String? locationNum;
	String? type;
	String? clientId;
	String? userId;
	String? name;
	String? inwardTime;
	String? outwardTime;
	String? showToClient;
	String? downloadable;
	String? dl;
	Null receiverName;
	Null note;
	String? outwardBy;

	Data({this.id, this.locationId, this.locationNum, this.type, this.clientId, this.userId, this.name, this.inwardTime, this.outwardTime, this.showToClient, this.downloadable, this.dl, this.receiverName, this.note, this.outwardBy});

	Data.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		locationId = json['location_id'];
		locationNum = json['location_num'];
		type = json['type'];
		clientId = json['client_id'];
		userId = json['user_id'];
		name = json['name'];
		inwardTime = json['inward_time'];
		outwardTime = json['outward_time'];
		showToClient = json['show_to_client'];
		downloadable = json['downloadable'];
		dl = json['dl'];
		receiverName = json['receiver_name'];
		note = json['note'];
		outwardBy = json['outward_by'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['location_id'] = this.locationId;
		data['location_num'] = this.locationNum;
		data['type'] = this.type;
		data['client_id'] = this.clientId;
		data['user_id'] = this.userId;
		data['name'] = this.name;
		data['inward_time'] = this.inwardTime;
		data['outward_time'] = this.outwardTime;
		data['show_to_client'] = this.showToClient;
		data['downloadable'] = this.downloadable;
		data['dl'] = this.dl;
		data['receiver_name'] = this.receiverName;
		data['note'] = this.note;
		data['outward_by'] = this.outwardBy;
		return data;
	}
}

class ClientData {
	String? id;
	String? text;

	ClientData({this.id, this.text});

	ClientData.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		text = json['text'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['text'] = this.text;
		return data;
	}
}

class Location {
	String? id;
	String? maxLimit;
	String? minLimit;
	String? sortTag;
	String? empDispatch;
	String? location;
	//String? default;
	String? dl;
	String? cnt;

	Location({this.id, this.maxLimit, this.minLimit, this.sortTag, this.empDispatch, this.location,  this.dl, this.cnt});

	Location.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		maxLimit = json['max_limit'];
		minLimit = json['min_limit'];
		sortTag = json['sort_tag'];
		empDispatch = json['emp_dispatch'];
		location = json['location'];
		//default = json['default'];
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
		//data['default'] = this.default;
		data['dl'] = this.dl;
		data['cnt'] = this.cnt;
		return data;
	}
}