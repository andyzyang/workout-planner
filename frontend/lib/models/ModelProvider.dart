/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'Exercise.dart';
import 'ExerciseCategory.dart';
import 'ExerciseCategoryExercise.dart';
import 'Routine.dart';
import 'RoutineExercise.dart';
import 'Set.dart';
import 'Workout.dart';

export 'Exercise.dart';
export 'ExerciseCategory.dart';
export 'ExerciseCategoryExercise.dart';
export 'Routine.dart';
export 'RoutineExercise.dart';
export 'Set.dart';
export 'Workout.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "39bb92063946fb36ca6c20081d000171";
  @override
  List<ModelSchema> modelSchemas = [
    Exercise.schema,
    ExerciseCategory.schema,
    ExerciseCategoryExercise.schema,
    Routine.schema,
    RoutineExercise.schema,
    Set.schema,
    Workout.schema
  ];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;

  ModelType getModelTypeByModelName(String modelName) {
    switch (modelName) {
      case "Exercise":
        {
          return Exercise.classType;
        }
        break;
      case "ExerciseCategory":
        {
          return ExerciseCategory.classType;
        }
        break;
      case "ExerciseCategoryExercise":
        {
          return ExerciseCategoryExercise.classType;
        }
        break;
      case "Routine":
        {
          return Routine.classType;
        }
        break;
      case "RoutineExercise":
        {
          return RoutineExercise.classType;
        }
        break;
      case "Set":
        {
          return Set.classType;
        }
        break;
      case "Workout":
        {
          return Workout.classType;
        }
        break;
      default:
        {
          throw Exception(
              "Failed to find model in model provider for model name: " +
                  modelName);
        }
    }
  }
}
