import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_planner/page_history.dart';

import 'api.dart';

class WorkoutPage extends StatefulWidget {
  final VoidCallback onSignOut;
  WorkoutPage({@required this.onSignOut});
  @override
  State<StatefulWidget> createState() {
    return _WorkoutPageState();
  }
}

class _WorkoutPageState extends State<WorkoutPage> {
  final newExerciseTextFieldController = TextEditingController();

  bool startPressed = true;
  bool stopPressed = true;
  bool resetPressed = false;
  String time = "00 : 00 : 00";
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  String textToSubmit = "";

  void showAddExerciseDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add an Exercise"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: newExerciseTextFieldController,
                decoration: InputDecoration(
                  hintText: "Exercise's name...",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                newExerciseTextFieldController.text = "";
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('ADD'),
              onPressed: () async {
                setState(() {
                  Api.addSetToWorkout(newExerciseTextFieldController.text,
                      Api.isStrength(newExerciseTextFieldController.text));
                  Api.workoutUpdate();
                  newExerciseTextFieldController.text = "";
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void showEmptyInputWarningDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Empty Input"),
          content: Text("Input cannot be empty."),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void clearAll(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Workout Records"),
          content: Text("Are you sure to delete all the records?"),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('DELETE'),
              onPressed: () async {
                setState(() {
                  Api.clearWorkout();
                  Api.workoutUpdate();
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void completeAll(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Finish Workout"),
          content: Text("Your records will be stored."),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                setState(() {
                  if (Api.someInputEmpty()) {
                    showEmptyInputWarningDialog(context);
                    return;
                  }
                  Api.completeWorkout();
                  Api.clearWorkout();
                  Api.workoutUpdate();
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void startTimer() {
    Timer(dur, keeprunning);
  }

  void keeprunning() {
    if (swatch.isRunning) {
      startTimer();
    }
    setState(() {
      time = swatch.elapsed.inHours.toString().padLeft(2, '0') +
          " : " +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
          " : " +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');
    });
  }

  void startStopWatch() {
    setState(() {
      stopPressed = false;
      startPressed = false;
    });
    swatch.start();
    startTimer();
  }

  void stopStopWatch() {
    setState(() {
      startPressed = true;
      stopPressed = true;
    });
    swatch.stop();
  }

  void resetStopWatch() {
    setState(() {
      startPressed = true;
      stopPressed = true;
    });
    swatch.stop();
    swatch.reset();
    time = "00 : 00 : 00";
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Workout"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Api.workoutCount(),
              itemBuilder: (context, int index) {
                String exerciseName =
                    Api.getWorkoutByIndex(index)["exerciseName"];
                List<Map<String, String>> sets =
                    Api.getWorkoutByIndex(index)["sets"];
                print(sets);
                return Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              color: Colors.black,
                              height: 36,
                            )),
                      ),
                      Text(
                        Api.getWorkoutByIndex(index)["exerciseName"],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              color: Colors.black,
                              height: 36,
                            )),
                      ),
                    ]),
                    (Api.isStrength(exerciseName))
                        ? DataTable(
                            columnSpacing: 35,
                            columns: [
                              DataColumn(label: Text('Set')),
                              DataColumn(label: Text('Reps')),
                              DataColumn(label: Text('Weight(lb)')),
                              DataColumn(label: Text('')),
                            ],
                            rows: sets
                                .map(
                                  ((set) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(
                                            Text(set["id"]),
                                          ),
                                          DataCell(
                                            Focus(
                                              child: TextFormField(
                                                initialValue: set["reps"],
                                                key: Key(set["reps"]),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                ],
                                                onChanged: (reps) {
                                                  textToSubmit = reps;
                                                },
                                              ),
                                              onFocusChange: (hasFocus) async {
                                                if (hasFocus)
                                                  await new Future.delayed(
                                                      const Duration(
                                                          milliseconds: 100));
                                                setState(() {
                                                  if (!hasFocus) {
                                                    // 100ms for this value assignment, please do not modify these 2 lines
                                                    String submit =
                                                        textToSubmit;
                                                    textToSubmit = "";
                                                    // upload data afterwards
                                                    set["reps"] = submit;
                                                    Api.workoutUpdate();
                                                  } else
                                                    textToSubmit = set["reps"];
                                                });
                                              },
                                            ),
                                            showEditIcon: true,
                                          ),
                                          DataCell(
                                            Focus(
                                              child: TextFormField(
                                                initialValue: set["weight"],
                                                key: Key(set["weight"]),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                ],
                                                onChanged: (weight) {
                                                  textToSubmit = weight;
                                                },
                                              ),
                                              onFocusChange: (hasFocus) async {
                                                if (hasFocus)
                                                  await new Future.delayed(
                                                      const Duration(
                                                          milliseconds: 100));
                                                setState(() {
                                                  if (!hasFocus) {
                                                    // 100ms for this value assignment, please do not modify these 2 lines
                                                    String submit =
                                                        textToSubmit;
                                                    textToSubmit = "";
                                                    // upload data afterwards
                                                    set["weight"] = submit;
                                                    Api.workoutUpdate();
                                                  } else
                                                    textToSubmit =
                                                        set["weight"];
                                                });
                                              },
                                            ),
                                            showEditIcon: true,
                                          ),
                                          DataCell(
                                            TextButton(
                                              child: Icon(Icons.close),
                                              onPressed: () async {
                                                setState(() {
                                                  sets.remove(set);
                                                  for (int i = 0;
                                                      i < sets.length;
                                                      i++) {
                                                    sets[i]["id"] =
                                                        (i + 1).toString();
                                                  }
                                                  Api.workoutUpdate();
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      )),
                                )
                                .toList(),
                          )
                        : DataTable(
                            columnSpacing: 10,
                            columns: [
                              DataColumn(label: Text('Set')),
                              DataColumn(label: Text('Hrs')),
                              DataColumn(label: Text(':')),
                              DataColumn(label: Text('Mins')),
                              DataColumn(label: Text(':')),
                              DataColumn(label: Text('Secs')),
                              DataColumn(label: Text('Distance(mi)')),
                              DataColumn(label: Text('')),
                            ],
                            rows: sets
                                .map(
                                  ((set) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(
                                            Text(set["id"]),
                                          ),
                                          DataCell(
                                            Container(
                                              width: 25,
                                              child: Focus(
                                                child: TextFormField(
                                                  initialValue: set["duration"]
                                                      .split(":")[0],
                                                  key: Key(set["duration"]
                                                      .split(":")[0]),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9]')),
                                                  ],
                                                  onChanged: (durationHr) {
                                                    textToSubmit = durationHr;
                                                  },
                                                ),
                                                onFocusChange:
                                                    (hasFocus) async {
                                                  if (hasFocus)
                                                    await new Future.delayed(
                                                        const Duration(
                                                            milliseconds: 100));
                                                  setState(() {
                                                    if (!hasFocus) {
                                                      // 100ms for this value assignment, please do not modify these 2 lines
                                                      String submit =
                                                          textToSubmit;
                                                      textToSubmit = "";
                                                      // upload data afterwards
                                                      var hrStringLength =
                                                          set["duration"]
                                                              .split(":")[0]
                                                              .length;
                                                      set["duration"] = set[
                                                              "duration"]
                                                          .replaceRange(
                                                              0,
                                                              hrStringLength,
                                                              submit);
                                                      Api.workoutUpdate();
                                                    } else
                                                      textToSubmit =
                                                          set["duration"]
                                                              .split(":")[0];
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          DataCell(Text(":")),
                                          DataCell(
                                            Container(
                                              width: 25,
                                              child: Focus(
                                                child: TextFormField(
                                                  initialValue: set["duration"]
                                                      .split(":")[1],
                                                  key: Key(set["duration"]
                                                      .split(":")[1]),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9]')),
                                                    new LengthLimitingTextInputFormatter(
                                                        2),
                                                  ],
                                                  onChanged: (durationMin) {
                                                    if (durationMin != "") {
                                                      durationMin = (int.parse(
                                                                  durationMin) %
                                                              60)
                                                          .toString();
                                                      textToSubmit = durationMin
                                                          .padLeft(2, '0');
                                                    } else
                                                      textToSubmit = "00";
                                                  },
                                                ),
                                                onFocusChange:
                                                    (hasFocus) async {
                                                  if (hasFocus)
                                                    await new Future.delayed(
                                                        const Duration(
                                                            milliseconds: 100));
                                                  setState(() {
                                                    if (!hasFocus) {
                                                      // 100ms for this value assignment, please do not modify these 2 lines
                                                      String submit =
                                                          textToSubmit;
                                                      textToSubmit = "";
                                                      // upload data afterwards
                                                      var hrStringLength =
                                                          set["duration"]
                                                              .split(":")[0]
                                                              .length;
                                                      var minStringLength =
                                                          set["duration"]
                                                              .split(":")[1]
                                                              .length;
                                                      set["duration"] = set[
                                                              "duration"]
                                                          .replaceRange(
                                                              hrStringLength +
                                                                  1,
                                                              hrStringLength +
                                                                  minStringLength +
                                                                  1,
                                                              submit);
                                                      Api.workoutUpdate();
                                                    } else
                                                      textToSubmit =
                                                          set["duration"]
                                                              .split(":")[1];
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          DataCell(Text(":")),
                                          DataCell(
                                            Container(
                                              width: 25,
                                              child: Focus(
                                                child: TextFormField(
                                                  initialValue: set["duration"]
                                                      .split(":")[2],
                                                  key: Key(set["duration"]
                                                      .split(":")[2]),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9]')),
                                                    new LengthLimitingTextInputFormatter(
                                                        2),
                                                  ],
                                                  onChanged: (durationSec) {
                                                    if (durationSec != "") {
                                                      durationSec = (int.parse(
                                                                  durationSec) %
                                                              60)
                                                          .toString();
                                                      textToSubmit = durationSec
                                                          .padLeft(2, '0');
                                                    } else
                                                      textToSubmit = "00";
                                                  },
                                                ),
                                                onFocusChange:
                                                    (hasFocus) async {
                                                  if (hasFocus)
                                                    await new Future.delayed(
                                                        const Duration(
                                                            milliseconds: 100));
                                                  setState(() {
                                                    if (!hasFocus) {
                                                      // 100ms for this value assignment, please do not modify these 2 lines
                                                      String submit =
                                                          textToSubmit;
                                                      textToSubmit = "";
                                                      // upload data afterwards
                                                      var secStringLength =
                                                          set["duration"]
                                                              .split(":")[2]
                                                              .length;
                                                      var totalStringLength =
                                                          set["duration"]
                                                              .length;
                                                      set["duration"] = set[
                                                              "duration"]
                                                          .replaceRange(
                                                              totalStringLength -
                                                                  secStringLength,
                                                              totalStringLength,
                                                              submit);
                                                      Api.workoutUpdate();
                                                    } else
                                                      textToSubmit =
                                                          set["duration"]
                                                              .split(":")[2];
                                                  });
                                                },
                                              ),
                                            ),
                                            showEditIcon: true,
                                          ),
                                          DataCell(
                                            Focus(
                                              child: TextFormField(
                                                initialValue: set["distance"],
                                                key: Key(set["distance"]),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                ],
                                                onChanged: (distance) {
                                                  textToSubmit = distance;
                                                },
                                              ),
                                              onFocusChange: (hasFocus) async {
                                                if (hasFocus)
                                                  await new Future.delayed(
                                                      const Duration(
                                                          milliseconds: 100));
                                                setState(() {
                                                  if (!hasFocus) {
                                                    // 100ms for this value assignment, please do not modify these 2 lines
                                                    String submit =
                                                        textToSubmit;
                                                    textToSubmit = "";
                                                    // upload data afterwards
                                                    set["distance"] = submit;
                                                    Api.workoutUpdate();
                                                  } else
                                                    textToSubmit =
                                                        set["distance"];
                                                });
                                              },
                                            ),
                                            showEditIcon: true,
                                          ),
                                          DataCell(
                                            TextButton(
                                              child: Icon(Icons.close),
                                              onPressed: () async {
                                                setState(() {
                                                  sets.remove(set);
                                                  for (int i = 0;
                                                      i < sets.length;
                                                      i++) {
                                                    sets[i]["id"] =
                                                        (i + 1).toString();
                                                  }
                                                  Api.workoutUpdate();
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      )),
                                )
                                .toList(),
                          ),
                    Container(
                      width: 150,
                      height: 50,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            sets.add(Api.isStrength(exerciseName)
                                ? {
                                    "id": (sets.length + 1).toString(),
                                    "reps": "",
                                    "weight": ""
                                  }
                                : {
                                    "id": (sets.length + 1).toString(),
                                    "duration": "::",
                                    "distance": ""
                                  });
                            Api.workoutUpdate();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlueAccent,
                        ),
                        child: Text(
                          "+ Add Set",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            color: Colors.grey,
            child: Row(
              children: <Widget>[
                Text(" "),
                Expanded(
                  child: TextButton(
                    onPressed: startPressed ? startStopWatch : null,
                    style: TextButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Icon(Icons.not_started),
                  ),
                ),
                Text(" "),
                Expanded(
                  child: TextButton(
                    onPressed: stopPressed ? null : stopStopWatch,
                    style: TextButton.styleFrom(
                      primary: Colors.yellow,
                    ),
                    child: Icon(Icons.pause),
                  ),
                ),
                Text(" "),
                Expanded(
                  child: TextButton(
                    onPressed: resetPressed ? null : resetStopWatch,
                    style: TextButton.styleFrom(
                      primary: Colors.blueAccent,
                    ),
                    child: Icon(Icons.restore),
                  ),
                ),
                Container(
                  width: 200,
                  alignment: Alignment.center,
                  child: Text(
                    time,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(" "),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Text(" "),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    clearAll(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                  ),
                  child: Text(
                    "Clear All",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Text(" "),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    completeAll(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent,
                  ),
                  child: Text(
                    "Complete All",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Text(" "),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddExerciseDialog(context);
        },
        tooltip: 'New Workout',
        child: Icon(Icons.add),
        backgroundColor: Colors.blue.withOpacity(0.75),
      ),
      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 100,
                child: DrawerHeader(
                  child: Text('Workout Planner',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
              ),
              ListTile(
                title: Text('History', style: TextStyle(fontSize: 20)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HistoryPageStateful()),
                  );
                },
              ),
              ListTile(
                title: Text('Sign Out', style: TextStyle(fontSize: 20)),
                onTap: () => widget.onSignOut(),
              ),
              ListTile(
                title: Text('More...', style: TextStyle(fontSize: 20)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
