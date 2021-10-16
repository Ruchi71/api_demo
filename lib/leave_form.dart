import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
/*import 'package:provider/provider.dart';


class LeaveForm extends StatefulWidget {
  const LeaveForm({Key key, this.type,this.id}) : super(key: key);
  final String type;
  final String id;

  @override
  _LeaveFormState createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (context) => MyModel(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          title: Text('Leave Apply'),
        ),
        body: Container(
          height: 1000,
          width: double.infinity,
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                child: Text(
                  'Leave Type',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30,5,30,0),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5
                      ),],

                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10,10,0,10),
                    child: Text(widget.type,style: TextStyle(
                        fontSize: 17
                    ),),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                    child: Text(
                      'Start Date',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(100, 20, 0, 0),
                    child: Text(
                      'End Date',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
                    child: Container(
                      height: 40,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7),
                        ],
                      ),
                      child: Consumer<MyModel>(
                          builder: (context, myModel, child) {
                            return ElevatedButton(
                              style: ButtonStyle(shape: MaterialStateProperty.all
                                (RoundedRectangleBorder(borderRadius:
                              BorderRadius.circular(5))),
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  shadowColor: MaterialStateProperty.all(Colors.blue)
                              ),
                              onPressed: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: myModel._dateTime == null ? DateTime.now() : myModel._dateTime,
                                    firstDate: DateTime(2001),
                                    lastDate: DateTime(2031)
                                ).then((date) {
                                  myModel.StartDate(date);

                                });
                              },
                              child: Consumer<MyModel>(
                                  builder: (context, myModel, child) {
                                    return Text(
                                      myModel._dateTime == null ? ''
                                          : myModel.dateformate.
                                      format(myModel._dateTime),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17),
                                    );}),
                            );

                          }
                      ),
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 5, 0, 0),
                    child: Container(
                      height: 40,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7),
                        ],
                      ),
                      child: Consumer<MyModel>(
                          builder: (context, myModel, child) {
                            return ElevatedButton(
                              style: ButtonStyle(shape: MaterialStateProperty.all
                                (RoundedRectangleBorder(borderRadius:
                              BorderRadius.circular(5))),
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  shadowColor: MaterialStateProperty.all(Colors.blue)
                              ),
                              onPressed: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: myModel._date == null ? DateTime.now() : myModel._date,
                                    firstDate: DateTime(2001),
                                    lastDate: DateTime(2031)
                                ).then((date) {
                                  myModel.EndDate(date);

                                });
                              },
                              child: Consumer<MyModel>(
                                  builder: (context, myModel, child) {
                                    return Text(myModel._date == null ? ''
                                        : myModel.dateformate
                                        .format(myModel._date),style: TextStyle(
                                        color: Colors.black,fontSize: 17),
                                    );}),
                            );

                          }
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                child: Text(
                  'Days',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
                child: Container(
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5),
                      ],
                    ),
                    child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                child: Text(
                  'Leave Reason',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30,5,20,0),
                child: Container(

                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5
                        ),],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: const EdgeInsets.fromLTRB(15,10,0,0),
                  child: TextFormField(
                    decoration: InputDecoration.collapsed(
                      hintText: "Leave Reason",
                    ),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    maxLines: 5,
                  ),
                ),
              ),

              widget.type == "Sick Leave"?medicalcontainer():Container(),



              Container(
                height: 70,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 20, 0),
                    child: ElevatedButton(onPressed: () {

                    },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Apply',style:
                          TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all
                          (RoundedRectangleBorder(borderRadius:
                        BorderRadius.circular(5))),
                        backgroundColor: MaterialStateProperty
                            .all(Colors.blue[700],),
                      ),
                    )
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  Container medicalcontainer() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
            child: Text(
              'Medical Certificate',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 35,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 20, 0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(30/360),
                        child: Icon(
                          Icons.attach_file,
                          size: 25,
                          color: Colors.blue[700],
                        ),
                      )
                    ],
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                    backgroundColor:
                    MaterialStateProperty.all(Colors.white),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(150,5,0,0),
            child: Text('Attach files JPG or Pdf',style: TextStyle(
              fontSize: 12,
            ),),
          ),

        ],
      ),
    );
  }
}

class MyModel with ChangeNotifier { //                          <--- MyModel
  DateTime _dateTime;
  DateTime _date;
  final dateformate = DateFormat("dd-MM-yyyy");

  void StartDate(date) {
    _dateTime = date;

    notifyListeners();
  }
  void EndDate(date) {
    _date = date;

    notifyListeners();
  }
}*/
