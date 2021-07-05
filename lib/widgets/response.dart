import 'package:grocery/widgets/data.dart';

class Response {
  int response;
  int error;
  int message;

  List<Data> result_array;

  static Response res;

  Response({
    this.response,
    this.error,
    this.message,
    this.result_array,
  });

  Response.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    error = json['error'];
    message = json['message'];

    if (json['result_array'] != null) {
      result_array = new List<Data>();
      json['result_array'].forEach((v) {
        result_array.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['error'] = this.error;
    data['message'] = this.message;

    if (this.result_array != null) {
      data['result_array'] = this.result_array.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
