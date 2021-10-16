import 'package:http/http.dart' as http;
import 'dart:convert';
import 'attendance_model_class.dart';

Future<UpdateModel> createUser(String log_type) async {
  final String apiUrl =
      "";

  final response = await http.post(Uri.parse(apiUrl),
      body:
      jsonEncode({"emp_id": "1", "log_type": log_type, "created_by": "2"}));

  if (response.statusCode == 200) {
    final String responseString = response.body;
    print('responnse status:${response.statusCode}');
    print('response body: ${responseString}');

    return updateModelFromJson(responseString);
  } else {
    return null;
  }
}