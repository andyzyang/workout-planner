import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'data.dart';

class Api {
  // =====================Checking=======================
  // ====================================================

  // Given the name of a exercise,
  // you can assume the name exists in the user's exercise list,
  // return true if exerciseName is Strength, false if it is Cardio.
  static bool isStrength(String exerciseName) {
    return Hive.box<MyExercise>('exercises').get(exerciseName).strength;
  }

  // Given the name of a exercise,
  // return true if exerciseName is in the user's exercise list,
  // return false otherwise.
  static bool exerciseNameExists(String exerciseName) {
    for (int i = 0; i < Hive.box<MyExercise>('exercises').length; i++) {
      if (Hive.box<MyExercise>('exercises').getAt(i).name == exerciseName)
        return true;
    }
    return false;
  }

  // Given the name of a category,
  // return true if categoryName is in the user's category list,
  // return false otherwise.
  static bool categoryNameExists(String categoryName) {
    for (int i = 0; i < Hive.box<Category>('categories').length; i++) {
      if (Hive.box<Category>('categories').getAt(i).name == categoryName)
        return true;
    }
    return false;
  }

  // Given the name of a routine,
  // return true if routineName is in the user's routine list,
  // return false otherwise.
  static bool routineNameExists(String routineName) {
    for (int i = 0; i < Hive.box<MyRoutine>('routines').length; i++) {
      if (Hive.box<MyRoutine>('routines').getAt(i).name == routineName)
        return true;
    }
    return false;
  }

  // Return whether the exercise: exerciseName
  // is in the category: categoryName
  // You can assume both names exist.
  static bool exerciseExistsInCategory(
      String exerciseName, String categoryName) {
    for (int i = 0; i < Hive.box<Category>('categories').length; i++) {
      if (Hive.box<Category>('categories').getAt(i).name == categoryName) {
        HiveList<MyExercise> exercises =
            Hive.box<Category>('categories').getAt(i).exercises;
        for (MyExercise exercise in exercises) {
          if (exercise.name == exerciseName) return true;
        }
      }
    }
    return false;
  }

  // Return whether the exercise: exerciseName
  // is in the routine: routineName
  // You can assume both names exist.
  static bool exerciseExistsInRoutine(String exerciseName, String routineName) {
    for (int i = 0; i < Hive.box<MyRoutine>('routines').length; i++) {
      if (Hive.box<MyRoutine>('routines').getAt(i).name == routineName) {
        HiveList<MyExercise> exercises =
            Hive.box<MyRoutine>('routines').getAt(i).exercises;
        for (MyExercise exercise in exercises) {
          if (exercise.name == exerciseName) return true;
        }
      }
    }
    return false;
  }

  // =======================CREATE=======================
  // ====================================================

  // Create an exercise with name: exerciseName.
  // Type of exercise is strength if strength == true.
  // Type of exercise is cardio if strength == false.
  static addExercise(String exerciseName, bool strength) {
    Hive.box<MyExercise>('exercises')
        .put(exerciseName, MyExercise(exerciseName, !strength, strength));
  }

  // Create a category with name: categoryName.
  static void addCategory(String categoryName) {
    var newCategory = Category(categoryName);
    newCategory.exercises = HiveList(Hive.box<MyExercise>('exercises'));
    Hive.box<Category>('categories').put(categoryName, newCategory);
  }

  // Create a routine with name: routineName.
  static void addRoutine(String routineName) {
    var newRoutine = MyRoutine(routineName);
    newRoutine.exercises = HiveList(Hive.box<MyExercise>('exercises'));
    Hive.box<MyRoutine>('routines').put(routineName, newRoutine);
  }

  // Create a set and append it to historical_data.
  // Type of exercise is strength.
  // exerciseName: name of the exercise (it's in the exercise list)
  // date: date of the record in mm/dd/yyyy format
  // reps: number of reps
  // lb: weight
  static void addSetStrength(
      String exerciseName, String date, String reps, String lb) {
    Hive.box('historical_data').add(
        {"exercise": exerciseName, "time": date, "reps": reps, "weight": lb});
  }

  // Create a set and append it to historical_data.
  // Type of exercise is cardio.
  // exerciseName: name of the exercise (it's in the exercise list)
  // date: date of the record in mm/dd/yyyy format
  // hr, min, sec: duration
  // mi: distance
  static void addSetCardio(String exerciseName, String date, String hr,
      String min, String sec, String mi) {
    Hive.box('historical_data').add({
      "exercise": exerciseName,
      "time": date,
      "duration": hr + ":" + min.padLeft(2, '0') + ":" + sec.padLeft(2, '0'),
      "distanceMi": mi
    });
  }

  // Add the exercise called exerciseName
  // to the category called categoryName.
  // You can assume both names exist.
  static void addExerciseToCategory(String exerciseName, String categoryName) {
    Hive.box<Category>('categories')
        .get(categoryName)
        .exercises
        .add(Hive.box<MyExercise>('exercises').get(exerciseName));
    Hive.box<Category>('categories').get(categoryName).save();
  }

  // Add the exercise called exerciseName
  // to the routine called routineName.
  // You can assume both names exist.
  static void addExerciseToRoutine(String exerciseName, String routineName) {
    Hive.box<MyRoutine>('routines')
        .get(routineName)
        .exercises
        .add(Hive.box<MyExercise>('exercises').get(exerciseName));
    Hive.box<MyRoutine>('routines').get(routineName).save();
  }

  // ========================GET=========================
  // ====================================================

  // Return the number of exercises in the user's exercise list.
  static int exerciseCount() {
    return Hive.box<MyExercise>('exercises').length;
  }

  // Return the number of categories in the user's category list.
  static int categoryCount() {
    return Hive.box<Category>('categories').length;
  }

  // Return the number of routines in the user's routine list.
  static int routineCount() {
    return Hive.box<MyRoutine>('routines').length;
  }

  // Return the name of the (index+1)-th exercise of the user's exercise list.
  // You can assume the index is valid.
  static String exerciseNameByIndex(int index) {
    return Hive.box<MyExercise>('exercises').keyAt(index);
  }

  // Return the name of the (index+1)-th category of the user's category list.
  // You can assume the index is valid.
  static String categoryNameByIndex(int index) {
    return Hive.box<Category>('categories').keyAt(index);
  }

  // Return the name of the (index+1)-th routine of the user's routine list.
  // You can assume the index is valid.
  static String routineNameByIndex(int index) {
    return Hive.box<MyRoutine>('routines').keyAt(index);
  }

  // Return a list of exercises in the category called categoryName.
  // You can assume this category exists in the user's category list.
  //
  // class MyExercise {
  //   String name;
  //   bool cardio;
  //   bool strength;
  //   MyExercise(this.name, this.cardio, this.strength);
  // }
  static List<MyExercise> exercisesOfCategory(String categoryName) {
    return Hive.box<Category>('categories').get(categoryName).exercises;
  }

  // Return a list of exercises in the routine called routineName.
  // You can assume this routine exists in the user's routine list.
  //
  // class Exercise {
  //   String name;
  //   bool cardio;
  //   bool strength;
  //   Exercise(this.name, this.cardio, this.strength);
  // }
  static List<MyExercise> exercisesOfRoutine(String routineName) {
    return Hive.box<MyRoutine>('routines').get(routineName).exercises;
  }

  // Return [todaysData, exercisesToday, repsToday, lbsToday, misToday].
  // todaysData: a sublist of historial_data whose data is today
  // exercisesToday: number of exercises the user does today
  // repsToday: number of reps today
  // lbsToday: number of lbs today (weight)
  // misToday: number of mis today (distance)
  static List<dynamic> getTodaysDataList() {
    var todaysData = [];
    for (var i = Hive.box('historical_data').length - 1; i >= 0; i--) {
      if (Hive.box('historical_data').getAt(i)["time"] ==
          DateFormat.yMd().format(DateTime.now())) {
        todaysData.add(Hive.box('historical_data').getAt(i));
      }
    }
    var exercisesToday = 0, repsToday = 0, lbsToday = 0.0, misToday = 0.0;
    var existingExercises = [];
    for (var i = 0; i < todaysData.length; i++) {
      if (!existingExercises.contains(todaysData[i]["exercise"])) {
        exercisesToday++;
        existingExercises.add(todaysData[i]["exercise"]);
      }
      if (isStrength(todaysData[i]["exercise"])) {
        repsToday += int.parse(todaysData[i]["reps"]);
        lbsToday += (double.parse(todaysData[i]["reps"]) *
            double.parse(todaysData[i]["weight"]));
      } else {
        misToday += double.parse(todaysData[i]["distanceMi"]);
      }
    }
    return [todaysData, exercisesToday, repsToday, lbsToday, misToday];
  }

  // Return the date of the set (in mm/dd/yyyy format)
  // whose date is the latest in historical_data
  // among those sets of exerciseName.
  // Return "Never" if there is no set of exerciseName is historical_data.
  //
  // You can assume exerciseName is in the user's exercise list.
  static String getLastCompletionTime(String exerciseName) {
    String lastCompletionTime = "Never";
    for (var i = 0; i < Hive.box('historical_data').length; i++) {
      if (Hive.box('historical_data').getAt(i)["exercise"] == exerciseName) {
        if (lastCompletionTime == "Never")
          lastCompletionTime = Hive.box('historical_data').getAt(i)["time"];
        else
          lastCompletionTime = (leftTimeLater(
                  Hive.box('historical_data').getAt(i)["time"],
                  lastCompletionTime))
              ? Hive.box('historical_data').getAt(i)["time"]
              : lastCompletionTime;
      }
    }
    return lastCompletionTime;
  }

  // =======================DELETE=======================
  // ====================================================

  // Delete the exercise whose name is deleteExerciseName.
  // You can assume this exercise exists in the user's exercise list.
  //
  // Remove the exercise from any category/routine that contains it.
  // Remove all the sets of this exercise from historical_data/workout.
  static void deleteExercise(String deleteExerciseName) {
    Hive.box<MyExercise>('exercises').delete(deleteExerciseName);
    Hive.box('historical_data')
        .keys
        .where((key) =>
            Hive.box('historical_data').get(key)["exercise"] ==
            deleteExerciseName)
        .forEach((key) {
      Hive.box('historical_data').delete(key);
    });
    for (int i = 0; i < Hive.box<Category>('categories').length; i++) {
      Hive.box<Category>('categories')
          .getAt(i)
          .exercises
          .removeWhere((exercise) => exercise.name == deleteExerciseName);
    }
    for (int i = 0; i < Hive.box<MyRoutine>('routines').length; i++) {
      Hive.box<MyRoutine>('routines')
          .getAt(i)
          .exercises
          .removeWhere((exercise) => exercise.name == deleteExerciseName);
    }
    Data.workout.removeWhere(
        (exercise) => exercise["exerciseName"] == deleteExerciseName);
  }

  // Delete the category with name: deleteCategoryName.
  // You can assume this category exists in the user's category list.
  static void deleteCategory(String deleteCategoryName) {
    Hive.box<Category>('categories').delete(deleteCategoryName);
  }

  // Delete the routine with name: deleteRoutineName.
  // You can assume this routine exists in the user's routine list.
  static void deleteRoutine(String deleteRoutineName) {
    Hive.box<MyRoutine>('routines').delete(deleteRoutineName);
  }

  // Remove the exercise called exerciseName
  // from the category called categoryName.
  // You can assume both names exist, and exerciseName is now in categoryName.
  static void removeExerciseFromCategory(
      String deleteExerciseName, String categoryName) {
    Hive.box<Category>('categories')
        .get(categoryName)
        .exercises
        .removeWhere((exercise) => exercise.name == deleteExerciseName);
  }

  // Remove the exercise called exerciseName
  // from the routine called routineName.
  // You can assume both names exist, and exerciseName is now in routineName.
  static void removeExerciseFromRoutine(
      String deleteExerciseName, String routineName) {
    Hive.box<MyRoutine>('routines')
        .get(routineName)
        .exercises
        .removeWhere((exercise) => exercise.name == deleteExerciseName);
  }

  // ======================Data.workout==================
  // ====================================================
  // Do not modify code related to Data.workout.

  // This function is called when Data.workout is updated.
  // Data.workout is a list like this:
  // [
  // {"exerciseName": "ex1", "sets": [{"id":"1","reps":"10","weight":"10"},{"id":"2","reps":"10","weight":"20"}]},
  // {"exerciseName": "ex2", "sets": [{"id":"1","duration":"1:10:00","distance":"10"},{"id":"2","duration":"2:10:00","distance":"20"},{"id":"3","duration":"2:59:59","distance":"30"}]}
  // ]
  // Update to cloud. Change format if necessary.
  static void workoutUpdate() {
    print("Data.workout is updated.");
  }

  // Return the length of Data.workout.
  static int workoutCount() {
    return Data.workout.length;
  }

  // Return the (index+1)-th element of Data.workout.
  static getWorkoutByIndex(int index) {
    return Data.workout[index];
  }

  // Append a new set to workout
  static void addSetToWorkout(String exerciseName, bool strength) {
    if (strength) {
      Data.workout.add({
        "exerciseName": exerciseName,
        "sets": [
          {"id": "1", "reps": "", "weight": ""}
        ]
      });
    } else {
      Data.workout.add({
        "exerciseName": exerciseName,
        "sets": [
          {"id": "1", "duration": "::", "distance": ""}
        ]
      });
    }
  }

  // Clear workout.
  static void clearWorkout() {
    Data.workout = [];
  }

  // Move all sets in workout to historical_Data.
  // Do not have to clear workout.
  static void completeWorkout() {
    for (int i = 0; i < Data.workout.length; i++) {
      String exerciseName = Data.workout[i]["exerciseName"];
      List<Map<String, String>> sets = Data.workout[i]["sets"];
      for (int j = 0; j < sets.length; j++) {
        if (isStrength(exerciseName)) {
          Hive.box('historical_data').add({
            "exercise": exerciseName,
            "time": DateFormat.yMd().format(DateTime.now()),
            "reps": sets[j]["reps"],
            "weight": sets[j]["weight"]
          });
        }
        if (Hive.box<MyExercise>('exercises').get(exerciseName).cardio) {
          Hive.box('historical_data').add({
            "exercise": exerciseName,
            "time": DateFormat.yMd().format(DateTime.now()),
            "duration": sets[j]["duration"],
            "distanceMi": sets[j]["distance"]
          });
        }
      }
    }
  }

  // Return true if any of "reps", "weight", "distance" of any set of Data.workout is empty string "".
  // e.g. workout = [
  // {"exerciseName": "ex1", "sets": [{"id":"1","reps":"10","weight":""}]},
  // ];
  //
  // Return true if any of hr/min/sec of "duration" of any set of Data.workout is empty.
  // e.g. workout = [
  // {"exerciseName": "ex2", "sets": [{"id":"1","duration":"1:10:","distance":"10"}]}
  // ];
  //
  // Return false otherwise.
  static bool someInputEmpty() {
    for (int i = 0; i < Data.workout.length; i++) {
      String exerciseName = Data.workout[i]["exerciseName"];
      List<Map<String, String>> sets = Data.workout[i]["sets"];
      for (int j = 0; j < sets.length; j++) {
        if (isStrength(exerciseName)) {
          if (sets[j]["reps"] == "" || sets[j]["weight"] == "") {
            return true;
          }
        } else {
          if (sets[j]["duration"].split(":")[0] == "" ||
              sets[j]["duration"].split(":")[1] == "" ||
              sets[j]["duration"].split(":")[2] == "" ||
              sets[j]["distance"] == "") {
            return true;
          }
        }
      }
    }
    return false;
  }

  // Given the name of an exercise: exerciseName,
  // and the start/end date (in mm/dd/yyyy format): dateFrom, dateTo.
  // Return a map of type Map<String, int>,
  // that maps date (in mm/dd/yyyy format) from dateFrom to dateTo,
  // to total lbs(if exerciseName is strength) or mis(if exerciseName is cardio) of that date.
  static Map<String, int> getMap(
      String exerciseName, String dateFrom, String dateTo) {
    Map<String, int> map = {};
    if (isStrength(exerciseName)) {
      for (var i = 0; i < Hive.box('historical_data').length; i++) {
        var data = Hive.box('historical_data').getAt(i);
        if ((data["exercise"] == exerciseName) &&
            (Api.leftTimeLater(data["time"], dateFrom) ||
                data["time"] == dateFrom) &&
            (Api.leftTimeLater(dateTo, data["time"]) ||
                data["time"] == dateTo)) {
          if (map.containsKey(data["time"])) {
            map.update(
                data["time"],
                (value) =>
                    value +
                    int.parse(data["reps"]) * int.parse(data["weight"]));
          } else {
            map[data["time"]] =
                int.parse(data["reps"]) * int.parse(data["weight"]);
          }
        }
      }
    } else {
      for (var i = 0; i < Hive.box('historical_data').length; i++) {
        var data = Hive.box('historical_data').getAt(i);
        if ((data["exercise"] == exerciseName) &&
            (Api.leftTimeLater(data["time"], dateFrom) ||
                data["time"] == dateFrom) &&
            (Api.leftTimeLater(dateTo, data["time"]) ||
                data["time"] == dateTo)) {
          if (map.containsKey(data["time"])) {
            map.update(
                data["time"], (value) => value + int.parse(data["distanceMi"]));
          } else {
            map[data["time"]] = int.parse(data["distanceMi"]);
          }
        }
      }
    }
    return map;
  }

  // =====================Other Methods==================
  // ====================================================

  // leftTime: mm/dd/yyyy
  // rightTime: mm/dd/yyyy
  // Returns true if the left time is later than the right.
  static bool leftTimeLater(String leftTime, String rightTime) {
    int leftMonth = int.parse(leftTime.split("/")[0]);
    int leftDay = int.parse(leftTime.split("/")[1]);
    int leftYear = int.parse(leftTime.split("/")[2]);
    int rightMonth = int.parse(rightTime.split("/")[0]);
    int rightDay = int.parse(rightTime.split("/")[1]);
    int rightYear = int.parse(rightTime.split("/")[2]);
    if (leftYear > rightYear) return true;
    if ((leftYear == rightYear) && (leftMonth > rightMonth)) return true;
    if ((leftYear == rightYear) &&
        (leftMonth == rightMonth) &&
        (leftDay > rightDay)) return true;
    return false;
  }
}
