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

/** This is an auto generated class representing the RoutineExercise type in your schema. */
@immutable
class RoutineExercise extends Model {
  static const classType = const _RoutineExerciseModelType();
  final String id;
  final Routine routine;
  final Exercise exercise;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const RoutineExercise._internal(
      {@required this.id, @required this.routine, @required this.exercise});

  factory RoutineExercise(
      {String id, @required Routine routine, @required Exercise exercise}) {
    return RoutineExercise._internal(
        id: id == null ? UUID.getUUID() : id,
        routine: routine,
        exercise: exercise);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RoutineExercise &&
        id == other.id &&
        routine == other.routine &&
        exercise == other.exercise;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("RoutineExercise {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write(
        "routine=" + (routine != null ? routine.toString() : "null") + ", ");
    buffer
        .write("exercise=" + (exercise != null ? exercise.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  RoutineExercise copyWith({String id, Routine routine, Exercise exercise}) {
    return RoutineExercise(
        id: id ?? this.id,
        routine: routine ?? this.routine,
        exercise: exercise ?? this.exercise);
  }

  RoutineExercise.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        routine = json['routine'] != null
            ? Routine.fromJson(new Map<String, dynamic>.from(json['routine']))
            : null,
        exercise = json['exercise'] != null
            ? Exercise.fromJson(new Map<String, dynamic>.from(json['exercise']))
            : null;

  Map<String, dynamic> toJson() =>
      {'id': id, 'routine': routine?.toJson(), 'exercise': exercise?.toJson()};

  static final QueryField ID = QueryField(fieldName: "routineExercise.id");
  static final QueryField ROUTINE = QueryField(
      fieldName: "routine",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Routine).toString()));
  static final QueryField EXERCISE = QueryField(
      fieldName: "exercise",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Exercise).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "RoutineExercise";
    modelSchemaDefinition.pluralName = "RoutineExercises";

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
        key: RoutineExercise.ROUTINE,
        isRequired: true,
        targetName: "routineId",
        ofModelName: (Routine).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: RoutineExercise.EXERCISE,
        isRequired: true,
        targetName: "exerciseId",
        ofModelName: (Exercise).toString()));
  });
}

class _RoutineExerciseModelType extends ModelType<RoutineExercise> {
  const _RoutineExerciseModelType();

  @override
  RoutineExercise fromJson(Map<String, dynamic> jsonData) {
    return RoutineExercise.fromJson(jsonData);
  }
}
