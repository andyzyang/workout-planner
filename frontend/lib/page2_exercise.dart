import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_planner/page_history.dart';
import 'api.dart';
import 'page_exercise.dart';

class ExercisePage extends StatefulWidget {
  final VoidCallback onSignOut;
  ExercisePage({@required this.onSignOut});
  @override
  State<StatefulWidget> createState() {
    return _ExercisePageState();
  }
}

class _ExercisePageState extends State<ExercisePage> {
  final newExerciseTextFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void showExerciseNameExistedWarningDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exercise Existed"),
          content: Text("Please add another exercise."),
          actions: <Widget>[
            ElevatedButton(
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
          title: Text("Add Exercise and Select Type"),
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
              child: Text('Strength'),
              onPressed: () {
                setState(() {
                  if (Api.exerciseNameExists(
                      newExerciseTextFieldController.text)) {
                    showExerciseNameExistedWarningDialog(context);
                    return;
                  }
                  Api.addExercise(newExerciseTextFieldController.text, true);
                  newExerciseTextFieldController.text = "";
                  Navigator.pop(context);
                });
              },
            ),
            TextButton(
              child: Text('Cardio'),
              onPressed: () async {
                setState(() {
                  if (Api.exerciseNameExists(
                      newExerciseTextFieldController.text)) {
                    showExerciseNameExistedWarningDialog(context);
                    return;
                  }
                  Api.addExercise(newExerciseTextFieldController.text, false);
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

  void showDeleteExerciseDialog(
      BuildContext context, String deleteExerciseName) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete the Exercise"),
          content:
              Text("Are you sure to delete the exercise and all its records?"),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('YES'),
              onPressed: () async {
                setState(() {
                  Api.deleteExercise(deleteExerciseName);
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Exercise"),
        backgroundColor: Colors.green,
      ),
      body: new ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: Api.exerciseCount(),
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(Api.exerciseNameByIndex(index)),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExercisePageStateful(
                          exerciseName: Api.exerciseNameByIndex(index))),
                );
              },
              onLongPress: () {
                showDeleteExerciseDialog(
                    context, Api.exerciseNameByIndex(index));
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddExerciseDialog(context);
        },
        tooltip: 'New Exercise',
        child: Icon(Icons.add),
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
                    color: Colors.green,
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
