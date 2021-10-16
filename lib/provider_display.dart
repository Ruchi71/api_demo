import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProviderDisplay extends StatefulWidget {
  const ProviderDisplay({Key key}) : super(key: key);

  @override
  _ProviderDisplayState createState() => _ProviderDisplayState();
}

class _ProviderDisplayState extends State<ProviderDisplay> {

  LoginApiResponse _apiResponse;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body:Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[

            TextField(
              controller: emailController,
            ),

            TextField(
              controller: passwordController,
            ),

            SizedBox(height: 32,),

            _apiResponse == null ? Container() :
            Text("The token ${_apiResponse.token}"),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final String email = emailController.text;
          final String password = passwordController.text;

          final LoginApiResponse user = await createUser(email, password);

          setState(() {
            _apiResponse = user;
          });

        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

Future<LoginApiResponse> createUser(String email, String password) async{
  final String apiUrl = "https://reqres.in/api/login";

  final response = await http.post(Uri.parse(apiUrl), body:jsonEncode( {
    "name": email,
    "job": password
  }));

  if(response.statusCode == 201){
    final String responseString = response.body;

    return loginApiResponseFromJson(responseString);
  }else{
    return null;
  }
}

LoginApiResponse loginApiResponseFromJson(String str) => LoginApiResponse.fromJson(json.decode(str));

String loginApiResponseToJson(LoginApiResponse data) => json.encode(data.toJson());

class LoginApiResponse {
  LoginApiResponse({
    this.id,
    this.token,
  });

  int id;
  String token;

  factory LoginApiResponse.fromJson(Map<String, dynamic> json) => LoginApiResponse(
    id: json["id"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
  };
}

