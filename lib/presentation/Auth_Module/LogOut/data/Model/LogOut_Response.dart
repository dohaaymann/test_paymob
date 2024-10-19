class LogOutResponse {
  String? message;
  List<dynamic>? data; // Use dynamic or a specific type if you know it
  bool? status;
  int? code;

  LogOutResponse({this.message, this.data, this.status, this.code});

  LogOutResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? List<dynamic>.from(json['data']) : null;
    status = json['status'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data;
    }
    data['status'] = this.status;
    data['code'] = this.code;
    return data;
  }
}
