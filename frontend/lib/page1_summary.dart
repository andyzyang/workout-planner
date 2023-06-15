import 'package:flutter/material.dart';
import 'package:workout_planner/page_history.dart';
import 'api.dart';

class SummaryPage extends StatefulWidget {
  final VoidCallback onSignOut;
  SummaryPage({@required this.onSignOut});
  @override
  State<StatefulWidget> createState() {
    return _SummaryPageState();
  }
}

class _SummaryPageState extends State<SummaryPage> {
  Widget build(BuildContext context) {
    var todaysDataList = Api.getTodaysDataList();
    var todaysData = todaysDataList[0];
    var exercisesToday = todaysDataList[1];
    var repsToday = todaysDataList[2];
    var lbsToday = todaysDataList[3];
    var misToday = todaysDataList[4];
    var setsToday = todaysData.length;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Summary"),
        backgroundColor: Colors.purple,
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(5),
          child: Text(
            "Today's Workout",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 4, color: Colors.black),
            ),
          ),
          child: Text(
            "Stats",
            style: TextStyle(fontSize: 25),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              "    Exercises Completed: " +
                  exercisesToday.toString() +
                  "\n    Sets Completed: " +
                  setsToday.toString() +
                  "\n    Reps Completed: " +
                  repsToday.toString() +
                  "\n    Lbs Lifted: " +
                  lbsToday.toString() +
                  "\n    Mis: " +
                  misToday.toString(),
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 4, color: Colors.black),
            ),
          ),
          child: Text(
            "Details",
            style: TextStyle(fontSize: 25),
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: todaysData.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(todaysData[index]["exercise"] +
                      " " +
                      todaysData[index]["time"]),
                  subtitle: (Api.isStrength(todaysData[index]["exercise"]))
                      ? Text(todaysData[index]["reps"] +
                          "reps @ " +
                          todaysData[index]["weight"] +
                          " LBS")
                      : Text("Duration: " +
                          todaysData[index]["duration"] +
                          "  Distance:" +
                          todaysData[index]["distanceMi"] +
                          " Mi"));
            },
          ),
        ),
      ]),
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
                    color: Colors.purple,
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
