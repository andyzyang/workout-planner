import 'dart:async';

import 'package:flutter/material.dart';
import 'api.dart';
import 'page_exercise.dart';

class RoutineDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Workout Planner",
      home: RoutinePageStateful(
        routineName: '',
      ),
    );
  }
}

class RoutinePageStateful extends StatefulWidget {
  final String routineName;
  RoutinePageStateful({Key key, @required this.routineName}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RoutinePageState(routineName);
  }
}

class _RoutinePageState extends State<RoutinePageStateful> {
  final String routineName;
  _RoutinePageState(this.routineName);
  final newExerciseTextFieldController = TextEditingController();

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

  void showExerciseNameDuplicateWarningDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exercise Existed in Routine"),
          content: Text("Please add another one."),
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

  void showAddExerciseDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add an Exercise in this Routine"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: newExerciseTextFieldController,
                decoration: InputDecoration(
                  hintText: "Exercise's Name...",
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
                  if (!Api.exerciseNameExists(
                      newExerciseTextFieldController.text)) {
                    showExerciseNameDoesNotExistWarningDialog(context);
                    return;
                  }
                  if (Api.exerciseExistsInRoutine(
                      newExerciseTextFieldController.text, routineName)) {
                    showExerciseNameDuplicateWarningDialog(context);
                    return;
                  }
                  Api.addExerciseToRoutine(
                      newExerciseTextFieldController.text, routineName);
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

  void showDeleteExerciseFromRoutineDialog(
      BuildContext context, String deleteExerciseName) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete the Exercise"),
          content:
              Text("Are you sure to remove the exercise from this routine?"),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('REMOVE'),
              onPressed: () async {
                setState(() {
                  Api.removeExerciseFromRoutine(
                      deleteExerciseName, routineName);
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  FutureOr refresh(dynamic value) {
    setState(() {});
  }

  void navigateExercisePage(String thisExerciseName) {
    Route route = MaterialPageRoute(
        builder: (context) =>
            ExercisePageStateful(exerciseName: thisExerciseName));
    Navigator.push(context, route).then(refresh);
  }

  Widget build(BuildContext context) {
    var exercisesOfThisRoutine = Api.exercisesOfRoutine(routineName);
    return Scaffold(
      appBar: AppBar(
        title: Text(routineName),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: new ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: exercisesOfThisRoutine.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(exercisesOfThisRoutine[index].name),
                    subtitle: Text("Last Completed: " +
                        Api.getLastCompletionTime(
                            exercisesOfThisRoutine[index].name)),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      navigateExercisePage(exercisesOfThisRoutine[index].name);
                    },
                    onLongPress: () {
                      showDeleteExerciseFromRoutineDialog(
                          context, exercisesOfThisRoutine[index].name);
                    });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddExerciseDialog(context);
        },
        tooltip: 'Add Exercise',
        child: Icon(Icons.add),
      ),
    );
  }
}
