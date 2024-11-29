class RegistrationModel {
  String? status;
  String? message;
  String? error;

  RegistrationModel({this.status, this.message, this.error});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}
