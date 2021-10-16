
import 'package:api_demo/attendance/attendance_location.dart';
import 'package:api_demo/circular/internal_circular.dart';
import 'package:api_demo/display_text.dart';
import 'package:api_demo/leave_first_main.dart';
import 'package:api_demo/leave_folder/leave_main.dart';
import 'package:api_demo/provider_display.dart';
import 'package:api_demo/provider_way1.dart';
import 'package:api_demo/provider_way1.dart';
import 'package:api_demo/rfid/attendance_rfid.dart';
import 'package:api_demo/rfid/login.dart';
import 'package:api_demo/time.dart';
import 'package:flutter/material.dart';
import 'package:api_demo/date_folder/input_date.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: AttendP(),
    );
  }
}

const kPrimaryColor = Color(0xFF0C9869);
const kSec = Color(0xFF80CBC4);

