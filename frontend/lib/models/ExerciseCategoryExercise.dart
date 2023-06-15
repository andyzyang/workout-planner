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

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the ExerciseCategoryExercise type in your schema. */
@immutable
class ExerciseCategoryExercise extends Model {
  static const classType = const _ExerciseCategoryExerciseModelType();
  final String id;
  final ExerciseCategory exerciseCategory;
  final Exercise exercise;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const ExerciseCategoryExercise._internal(
      {@required this.id,
      @required this.exerciseCategory,
      @required this.exercise});

  factory ExerciseCategoryExercise(
      {String id,
      @required ExerciseCategory exerciseCategory,
      @required Exercise exercise}) {
    return ExerciseCategoryExercise._internal(
        id: id == null ? UUID.getUUID() : id,
        exerciseCategory: exerciseCategory,
        exercise: exercise);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExerciseCategoryExercise &&
        id == other.id &&
        exerciseCategory == other.exerciseCategory &&
        exercise == other.exercise;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("ExerciseCategoryExercise {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("exerciseCategory=" +
        (exerciseCategory != null ? exerciseCategory.toString() : "null") +
        ", ");
    buffer
        .write("exercise=" + (exercise != null ? exercise.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  ExerciseCategoryExercise copyWith(
      {String id, ExerciseCategory exerciseCategory, Exercise exercise}) {
    return ExerciseCategoryExercise(
        id: id ?? this.id,
        exerciseCategory: exerciseCategory ?? this.exerciseCategory,
        exercise: exercise ?? this.exercise);
  }

  ExerciseCategoryExercise.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        exerciseCategory = json['exerciseCategory'] != null
            ? ExerciseCategory.fromJson(
                new Map<String, dynamic>.from(json['exerciseCategory']))
            : null,
        exercise = json['exercise'] != null
            ? Exercise.fromJson(new Map<String, dynamic>.from(json['exercise']))
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'exerciseCategory': exerciseCategory?.toJson(),
        'exercise': exercise?.toJson()
      };

  static final QueryField ID =
      QueryField(fieldName: "exerciseCategoryExercise.id");
  static final QueryField EXERCISECATEGORY = QueryField(
      fieldName: "exerciseCategory",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (ExerciseCategory).toString()));
  static final QueryField EXERCISE = QueryField(
      fieldName: "exercise",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Exercise).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ExerciseCategoryExercise";
    modelSchemaDefinition.pluralName = "ExerciseCategoryExercises";

    modelSchemaDefinition.authRules = [
      AuthRule(
          authStrategy: AuthStrategy.OWNER,
          ownerField: "owner",
          identityClaim: "cognito:username",
          operations: [
            ModelOperation.CREATE,
            ModelOperation.UPDATE,
            ModelOperation.DELETE,
            ModelOperation.READ
          ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: ExerciseCategoryExercise.EXERCISECATEGORY,
        isRequired: true,
        targetName: "exerciseCategoryId",
        ofModelName: (ExerciseCategory).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: ExerciseCategoryExercise.EXERCISE,
        isRequired: true,
        targetName: "exerciseId",
        ofModelName: (Exercise).toString()));
  });
}

class _ExerciseCategoryExerciseModelType
    extends ModelType<ExerciseCategoryExercise> {
  const _ExerciseCategoryExerciseModelType();

  @override
  ExerciseCategoryExercise fromJson(Map<String, dynamic> jsonData) {
    return ExerciseCategoryExercise.fromJson(jsonData);
  }
}
