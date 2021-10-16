import 'package:http/http.dart' as http;
import 'dart:convert';


UpdateModel updateModelFromJson(String str) =>
    UpdateModel.fromJson(json.decode(str));

String updateModelToJson(UpdateModel data) => json.encode(data.toJson());

class UpdateModel {
  UpdateModel({
    this.log_type,
  });

  String log_type;

  factory UpdateModel.fromJson(Map<String, dynamic> json) => UpdateModel(
    log_type: json["log_type"],
  );

  Map<String, dynamic> toJson() => {
    "log_type": log_type,
  };
}
