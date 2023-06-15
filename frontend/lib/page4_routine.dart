import 'package:flutter/material.dart';
import 'package:workout_planner/page_history.dart';
import 'api.dart';
import 'page_routine.dart';

class RoutinePage extends StatefulWidget {
  final VoidCallback onSignOut;
  RoutinePage({@required this.onSignOut});
  @override
  State<StatefulWidget> createState() {
    return _RoutinePageState();
  }
}

class _RoutinePageState extends State<RoutinePage> {
  final newRoutineTextFieldController = TextEditingController();
  final workoutTextFieldController = TextEditingController();

  void showRoutineNameExistedWarningDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Routine Name Existed"),
          content: Text("Please use another name."),
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

  void showAddRoutineDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Create a Routine"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: newRoutineTextFieldController,
                decoration: InputDecoration(
                  hintText: "Routine's Name...",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                newRoutineTextFieldController.text = "";
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('ADD'),
              onPressed: () async {
                setState(() {
                  if (Api.routineNameExists(
                      newRoutineTextFieldController.text)) {
                    showRoutineNameExistedWarningDialog(context);
                    return;
                  }
                  Api.addRoutine(newRoutineTextFieldController.text);
                  newRoutineTextFieldController.text = "";
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void showDeleteRoutineDialog(BuildContext context, String deleteRoutineName) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete the Routine"),
          content: Text("Are you sure to delete the Routine?"),
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
                  Api.deleteRoutine(deleteRoutineName);
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Routine"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: Api.routineCount(),
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(Api.routineNameByIndex(index)),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RoutinePageStateful(
                                routineName: Api.routineNameByIndex(index))),
                      );
                    },
                    onLongPress: () {
                      showDeleteRoutineDialog(
                          context, Api.routineNameByIndex(index));
                    });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddRoutineDialog(context);
        },
        tooltip: 'New Routine',
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
                    color: Colors.red,
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
