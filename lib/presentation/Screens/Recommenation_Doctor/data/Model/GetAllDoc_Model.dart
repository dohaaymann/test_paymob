class GetAllDoctor {
  List<Data>? data;
  GetAllDoctor({this.data});

  GetAllDoctor.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? photo;
  String? gender;
  String? address;
  String? description;
  String? degree;
  Specialization? specialization;
  City? city;
  int? appointPrice;
  String? startTime;
  String? endTime;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.photo,
        this.gender,
        this.address,
        this.description,
        this.degree,
        this.specialization,
        this.city,
        this.appointPrice,
        this.startTime,
        this.endTime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    gender = json['gender'];
    address = json['address'];
    description = json['description'];
    degree = json['degree'];
    specialization = json['specialization'] != null
        ? new Specialization.fromJson(json['specialization'])
        : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    appointPrice = json['appoint_price'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['description'] = this.description;
    data['degree'] = this.degree;
    if (this.specialization != null) {
      data['specialization'] = this.specialization!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['appoint_price'] = this.appointPrice;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}

class Specialization {
  int? id;
  String? name;

  Specialization({this.id, this.name});

  Specialization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class City {
  int? id;
  String? name;
  Specialization? governrate;

  City({this.id, this.name, this.governrate});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    governrate = json['governrate'] != null
        ? new Specialization.fromJson(json['governrate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.governrate != null) {
      data['governrate'] = this.governrate!.toJson();
    }
    return data;
  }
}