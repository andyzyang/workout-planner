import 'package:hive/hive.dart';

part 'data.g.dart';

class Data {
  // *******page 5*******
  // all workout displayed in page 5
  static var workout = [];
  // workout = [
  // {"exerciseName": "ex1", "sets": [{"id":"1","reps":"10","weight":"10"},{"id":"2","reps":"10","weight":"20"}]},
  // {"exerciseName": "ex2", "sets": [{"id":"1","duration":"1:10:00","distance":"10"},{"id":"2","duration":"2:10:00","distance":"20"},{"id":"3","duration":"2:59:59","distance":"30"}]}
  // ];
}

@HiveType(typeId: 0)
class MyExercise extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  bool cardio;
  @HiveField(2)
  bool strength;

  MyExercise(this.name, this.cardio, this.strength);
}

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  HiveList<MyExercise> exercises;

  Category(this.name);
}

// Routine r1 = new Routine("r1");
// r1.routineName == "r1"
// r1.exercises = ["ex1","ex2"];
@HiveType(typeId: 2)
class MyRoutine extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  HiveList<MyExercise> exercises;

  MyRoutine(this.name);
}
