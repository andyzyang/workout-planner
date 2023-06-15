import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:workout_planner/page_chart.dart';

import 'api.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Workout Planner",
      home: HistoryPageStateful(),
    );
  }
}

class HistoryPageStateful extends StatefulWidget {
  HistoryPageStateful({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HistoryPageState();
  }
}

class _HistoryPageState extends State<HistoryPageStateful> {
  _HistoryPageState();

  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  TextEditingController _dateFromController = TextEditingController();
  TextEditingController _dateToController = TextEditingController();
  TextEditingController _exerciseNameController = TextEditingController();

  Future<Null> _selectDateFrom(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateFrom,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDateFrom = picked;
        _dateFromController.text = DateFormat.yMd().format(selectedDateFrom);
      });
  }

  Future<Null> _selectDateTo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTo,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDateTo = picked;
        _dateToController.text = DateFormat.yMd().format(selectedDateTo);
      });
  }

  void showInvalidDateWarningDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Invalid Date"),
          content: Text("Please check your input."),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showExerciseNameDoesNotExistWarningDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exercise Not Found"),
          content: Text("This exercise is not in your list."),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _dateFromController.text = DateFormat.yMd().format(DateTime.now());
    _dateToController.text = DateFormat.yMd().format(DateTime.now());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("History"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Search for Historical Data",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  "DATE FROM",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    _selectDateFrom(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dateFromController,
                      onSaved: (String val) {},
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.only(top: 0.0)),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  "DATE TO",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    _selectDateTo(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dateToController,
                      onSaved: (String val) {},
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.only(top: 0.0)),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  "Exercise Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: TextFormField(
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                    enabled: true,
                    keyboardType: TextInputType.text,
                    controller: _exerciseNameController,
                    decoration: InputDecoration(
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.only(top: 0.0)),
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 50,
                padding: EdgeInsets.all(5),
                child: TextButton(
                  onPressed: () {
                    String dateFrom = _dateFromController.text;
                    String dateTo = _dateToController.text;
                    String exerciseName = _exerciseNameController.text;
                    if (Api.leftTimeLater(dateFrom, dateTo)) {
                      showInvalidDateWarningDialog(context);
                    } else if (!Api.exerciseNameExists(exerciseName)) {
                      showExerciseNameDoesNotExistWarningDialog(context);
                    } else {
                      _exerciseNameController.text = "";
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChartPage(exerciseName, dateFrom, dateTo)),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent,
                  ),
                  child: Text(
                    "View Chart",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
