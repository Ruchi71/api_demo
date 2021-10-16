/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class ContactShow extends StatefulWidget {
  const ContactShow({Key key}) : super(key: key);

  @override
  _ContactShowState createState() => _ContactShowState();
}

class _ContactShowState extends State<ContactShow> {

  final String apiUrl =
      "";

  Future fetchUsers() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text(snapshot.data['id']),
                  Text(snapshot.data['contact_person_name']),
                ],
              );
            }
            else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}*/

/*class AboutApi extends StatefulWidget {
  const AboutApi({Key key}) : super(key: key);

  @override
  _AboutApiState createState() => _AboutApiState();
}

class _AboutApiState extends State<AboutApi> {
  final String apiUrl =
      "";

  Future fetchUsers() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text(snapshot.data['data']['id']),
                  Text(snapshot.data['data']['name']),
                ],
              );
            }
            else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}*/

/*class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  UserModel _user;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

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
              controller: nameController,
            ),

            TextField(
              controller: jobController,
            ),

            SizedBox(height: 32,),

            _user == null ? Container() :
            Text("The user ${_user.name}, ${_user.id} is created successfully at time ${_user.createdAt.toIso8601String()}"),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final String name = nameController.text;
          final String jobTitle = jobController.text;

          final UserModel user = await createUser(name, jobTitle);

          setState(() {
            _user = user;
          });

        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<UserModel> createUser(String name, String jobTitle) async{
  final String apiUrl = "https://reqres.in/api/users";
  final response = await http.post(Uri.parse(apiUrl), body: {
    "name": name,
    "job": jobTitle
  });

  if(response.statusCode == 201){
    final String responseString = response.body;

    return userModelFromJson(responseString);
  }else{
    return null;
  }
}

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String name;
  String job;
  String id;
  DateTime createdAt;

  UserModel({
    this.name,
    this.job,
    this.id,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    job: json["job"],
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "job": job,
    "id": id,
    "createdAt": createdAt.toIso8601String(),
  };
}*/
/*class ProviderApi extends StatefulWidget {
  const ProviderApi({Key key}) : super(key: key);

  @override
  _ProviderApiState createState() => _ProviderApiState();
}

class _ProviderApiState extends State<ProviderApi> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (context) => MyModel(),
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(
            children: [
              Consumer<MyModel>(builder: (context, myModel, child) {
                return TextField(
                  decoration: InputDecoration(hintText: "job"),
                  controller: myModel.nameController,
                );}),
    Consumer<MyModel>(builder: (context, myModel, child) {
    return TextField(
      decoration: InputDecoration(hintText: "job"),
      controller: myModel.jobController,
    );}),

              Consumer<MyModel>(builder: (context, myModel, child) {
                return myModel._model == null
                    ? Container()
                    : Text("name is ${myModel._model.name} job is ${myModel._model.job} id is ${myModel._model.id} createdat ${myModel._model.createdAt.toIso8601String()}  ");
              })
            ],
          ),
        ),
        floatingActionButton:
        Consumer<MyModel>(builder: (context, myModel, child) {
          return FloatingActionButton(
            tooltip: 'Increment',
            child: Icon(Icons.add),
            onPressed: () async {


              await myModel.getdata();
            },
          );
        }),
      ),
    );
  }
}

class MyModel with ChangeNotifier {
  UserModel _model;
  String name;
  String jobtitle;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();


  void getdata() async {
    final String name = nameController.text;
    final String jobtitle = jobController.text;

    final UserModel userdata = await createUser(name, jobtitle);

    _model = userdata;
    notifyListeners();
  }
}

Future<UserModel> createUser(String name, String jobtitle) async {
  final String apiUrl = "https://reqres.in/api/users";

  final response = await http.post(Uri.parse(apiUrl),
      body: {"name": name, "job": jobtitle});

  if (response.statusCode == 201) {
    final String responseString = response.body;

    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String name;
  String job;
  String id;
  DateTime createdAt;

  UserModel({
    this.name,
    this.job,
    this.id,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    job: json["job"],
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "job": job,
    "id": id,
    "createdAt": createdAt.toIso8601String(),
  };
}*/

/*class LoginProvider extends StatefulWidget {
  const LoginProvider({Key key}) : super(key: key);

  @override
  _LoginProviderState createState() => _LoginProviderState();
}

class _LoginProviderState extends State<LoginProvider> {

  SharedPreferences logindata;
  bool newuser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => ProfilePage()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (context) => MyModel(),
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(
            children: [
              Consumer<MyModel>(builder: (context, myModel, child) {
                return TextField(
                  decoration: InputDecoration(hintText: "username"),
                  controller: myModel.nameController,
                );}),
              Consumer<MyModel>(builder: (context, myModel, child) {
                return TextField(
                  decoration: InputDecoration(hintText: "pasword"),
                  controller: myModel.passwordController,
                );}),

              Consumer<MyModel>(builder: (context, myModel, child) {
                return myModel._model == null
                    ? Container()
                    : Text("status is ${myModel._model.status}   ");
              })
            ],
          ),
        ),
        floatingActionButton:
        Consumer<MyModel>(builder: (context, myModel, child) {
          return FloatingActionButton(
            tooltip: 'Increment',
            child: Icon(Icons.add),
            onPressed: () async {
              await myModel.getdata();
              final snackbarfail = SnackBar(content: Text("login failed"));
              myModel._model.status == true?
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) =>
                      ProfilePage()))
                  :
              Scaffold.of(context).showSnackBar(snackbarfail);

              if (myModel.username != '' && myModel.password != '') {
                print('Successfull');
                logindata.setBool('login', false);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              }

            },
          );
        }),
      ),
    );
  }
}

class MyModel with ChangeNotifier {
  UserModel _model;
  String username;
  String password;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  void getdata() async {
    final String username = nameController.text;
    final String password = passwordController.text;

    final UserModel userdata = await createUser(username, password);

    _model = userdata;
    notifyListeners();
  }
}

Future<UserModel> createUser(String username,String password) async{
  final String apiUrl = "";

  final response = await http.post(Uri.parse(apiUrl), body:jsonEncode({
    "username": username,
    "password": password
  }));

  if(response.statusCode == 200){
    final String responseString = response.body;
    print(responseString);

    return userModelFromJson(responseString);
  }else{
    return null;
  }
}

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.status,
  });

  bool status;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],

  );

  Map<String, dynamic> toJson() => {
    "status": status,

  };
}*/
