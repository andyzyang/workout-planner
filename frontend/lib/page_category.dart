import 'package:flutter/material.dart';
import 'api.dart';
import 'page_exercise.dart';

class CategoryDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Workout Planner",
      home: CategoryPageStateful(
        categoryName: '',
      ),
    );
  }
}

class CategoryPageStateful extends StatefulWidget {
  final String categoryName;
  CategoryPageStateful({Key key, @required this.categoryName})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CategoryPageState(categoryName);
  }
}

class _CategoryPageState extends State<CategoryPageStateful> {
  final String categoryName;
  _CategoryPageState(this.categoryName);
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
          title: Text("Exercise Existed in Category"),
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
          title: Text("Add an Exercise"),
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
                  if (Api.exerciseExistsInCategory(
                      newExerciseTextFieldController.text, categoryName)) {
                    showExerciseNameDuplicateWarningDialog(context);
                    return;
                  }
                  Api.addExerciseToCategory(
                      newExerciseTextFieldController.text, categoryName);
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

  void showDeleteExerciseFromCategoryDialog(
      BuildContext context, String deleteExerciseName) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete the Exercise"),
          content:
              Text("Are you sure to remove the exercise from this category?"),
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
                  Api.removeExerciseFromCategory(
                      deleteExerciseName, categoryName);
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
    var exercisesOfThisCategory = Api.exercisesOfCategory(categoryName);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: new ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: exercisesOfThisCategory.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(exercisesOfThisCategory[index].name),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExercisePageStateful(
                                exerciseName:
                                    exercisesOfThisCategory[index].name)),
                      );
                    },
                    onLongPress: () {
                      showDeleteExerciseFromCategoryDialog(
                          context, exercisesOfThisCategory[index].name);
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
