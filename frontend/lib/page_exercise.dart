import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'api.dart';

class ExerciseDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Workout Planner",
      home: ExercisePageStateful(
        exerciseName: '',
      ),
    );
  }
}

class ExercisePageStateful extends StatefulWidget {
  final String exerciseName;
  ExercisePageStateful({Key key, @required this.exerciseName})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ExercisePageState(exerciseName);
  }
}

class _ExercisePageState extends State<ExercisePageStateful> {
  final String exerciseName;
  _ExercisePageState(this.exerciseName);

  String dateTime;
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _durationHrController = TextEditingController();
  TextEditingController _durationMinController = TextEditingController();
  TextEditingController _durationSecController = TextEditingController();
  TextEditingController _distanceController = TextEditingController();
  TextEditingController _repsController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  void showInvalidInputWarningDialog(BuildContext context, String message) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Invalid Input"),
          content: Text(message),
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
    _dateController.text = DateFormat.yMd().format(DateTime.now());
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  void addRecord() {
    String date = _dateController.text;
    String reps = _repsController.text;
    String lb = _weightController.text;
    String hr = _durationHrController.text;
    String min = _durationMinController.text;
    String sec = _durationSecController.text;
    String mi = _distanceController.text;

    if (Api.isStrength(exerciseName)) {
      if (reps == "" || lb == "") {
        showInvalidInputWarningDialog(context, "Input cannot be empty.");
        return;
      }
    } else {
      if (hr == "" || min == "" || sec == "" || mi == "") {
        showInvalidInputWarningDialog(context, "Input cannot be empty.");
        return;
      }
      if (int.parse(min) > 59) {
        showInvalidInputWarningDialog(context, "Min > 59");
        return;
      }
      if (int.parse(sec) > 59) {
        showInvalidInputWarningDialog(context, "Sec > 59");
        return;
      }
    }

    _durationHrController.text = "";
    _durationMinController.text = "";
    _durationSecController.text = "";
    _distanceController.text = "";
    _repsController.text = "";
    _weightController.text = "";

    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Record Created"),
          content: Text("You can see it in your exercise history now!"),
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

    if (Api.isStrength(exerciseName)) {
      Api.addSetStrength(exerciseName, date, reps, lb);
    } else {
      Api.addSetCardio(exerciseName, date, hr, min, sec, mi);
    }
  }

  Widget build(BuildContext context) {
    if (Api.isStrength(exerciseName)) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(exerciseName),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Create an Exercise Record",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "DATE",
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
                      _selectDate(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: TextFormField(
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        controller: _dateController,
                        onSaved: (String val) {},
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.only(top: 0.0)),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "REPS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 100.0,
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                    controller: _repsController,
                    decoration: const InputDecoration(hintText: "REPS"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "WEIGHT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 100.0,
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                    controller: _weightController,
                    decoration: const InputDecoration(hintText: "LB"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ),
                ),
                Container(
                  width: 300,
                  height: 50,
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: addRecord,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent,
                    ),
                    child: Text(
                      "Add to My Record",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (!Api.isStrength(exerciseName)) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(exerciseName),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Create an Exercise Record",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "DATE",
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
                      _selectDate(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: TextFormField(
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        controller: _dateController,
                        onSaved: (String val) {},
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.only(top: 0.0)),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "DURATION",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                          controller: _durationHrController,
                          decoration: const InputDecoration(hintText: "HR"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                        ),
                      ),
                      Text(
                        ":",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 100.0,
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                          controller: _durationMinController,
                          decoration: const InputDecoration(hintText: "MIN"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            new LengthLimitingTextInputFormatter(2),
                          ],
                        ),
                      ),
                      Text(
                        ":",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 100.0,
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                          controller: _durationSecController,
                          decoration: const InputDecoration(hintText: "SEC"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            new LengthLimitingTextInputFormatter(2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "DISTANCE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 100.0,
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                    controller: _distanceController,
                    decoration: const InputDecoration(hintText: "MI"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ),
                ),
                Container(
                  width: 300,
                  height: 50,
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: addRecord,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent,
                    ),
                    child: Text(
                      "Add to My Record",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: Center(
        child: Text("There's an error"),
      ),
    );
  }
}
