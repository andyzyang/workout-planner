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

/** This is an auto generated class representing the Set type in your schema. */
@immutable
class Set extends Model {
  static const classType = const _SetModelType();
  final String id;
  final Exercise exercise;
  final Workout workout;
  final String executionDate;
  final String note;
  final double weightLbs;
  final double reps;
  final double distanceMiles;
  final double durationSecs;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Set._internal(
      {@required this.id,
      @required this.exercise,
      @required this.workout,
      @required this.executionDate,
      this.note,
      this.weightLbs,
      this.reps,
      this.distanceMiles,
      this.durationSecs});

  factory Set(
      {String id,
      @required Exercise exercise,
      @required Workout workout,
      @required String executionDate,
      String note,
      double weightLbs,
      double reps,
      double distanceMiles,
      double durationSecs}) {
    return Set._internal(
        id: id == null ? UUID.getUUID() : id,
        exercise: exercise,
        workout: workout,
        executionDate: executionDate,
        note: note,
        weightLbs: weightLbs,
        reps: reps,
        distanceMiles: distanceMiles,
        durationSecs: durationSecs);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Set &&
        id == other.id &&
        exercise == other.exercise &&
        workout == other.workout &&
        executionDate == other.executionDate &&
        note == other.note &&
        weightLbs == other.weightLbs &&
        reps == other.reps &&
        distanceMiles == other.distanceMiles &&
        durationSecs == other.durationSecs;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Set {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write(
        "exercise=" + (exercise != null ? exercise.toString() : "null") + ", ");
    buffer.write(
        "workout=" + (workout != null ? workout.toString() : "null") + ", ");
    buffer.write("executionDate=" + "$executionDate" + ", ");
    buffer.write("note=" + "$note" + ", ");
    buffer.write("weightLbs=" +
        (weightLbs != null ? weightLbs.toString() : "null") +
        ", ");
    buffer.write("reps=" + (reps != null ? reps.toString() : "null") + ", ");
    buffer.write("distanceMiles=" +
        (distanceMiles != null ? distanceMiles.toString() : "null") +
        ", ");
    buffer.write("durationSecs=" +
        (durationSecs != null ? durationSecs.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Set copyWith(
      {String id,
      Exercise exercise,
      Workout workout,
      String executionDate,
      String note,
      double weightLbs,
      double reps,
      double distanceMiles,
      double durationSecs}) {
    return Set(
        id: id ?? this.id,
        exercise: exercise ?? this.exercise,
        workout: workout ?? this.workout,
        executionDate: executionDate ?? this.executionDate,
        note: note ?? this.note,
        weightLbs: weightLbs ?? this.weightLbs,
        reps: reps ?? this.reps,
        distanceMiles: distanceMiles ?? this.distanceMiles,
        durationSecs: durationSecs ?? this.durationSecs);
  }

  Set.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        exercise = json['exercise'] != null
            ? Exercise.fromJson(new Map<String, dynamic>.from(json['exercise']))
            : null,
        workout = json['workout'] != null
            ? Workout.fromJson(new Map<String, dynamic>.from(json['workout']))
            : null,
        executionDate = json['executionDate'],
        note = json['note'],
        weightLbs = json['weightLbs'],
        reps = json['reps'],
        distanceMiles = json['distanceMiles'],
        durationSecs = json['durationSecs'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'exercise': exercise?.toJson(),
        'workout': workout?.toJson(),
        'executionDate': executionDate,
        'note': note,
        'weightLbs': weightLbs,
        'reps': reps,
        'distanceMiles': distanceMiles,
        'durationSecs': durationSecs
      };

  static final QueryField ID = QueryField(fieldName: "set.id");
  static final QueryField EXERCISE = QueryField(
      fieldName: "exercise",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Exercise).toString()));
  static final QueryField WORKOUT = QueryField(
      fieldName: "workout",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Workout).toString()));
  static final QueryField EXECUTIONDATE =
      QueryField(fieldName: "executionDate");
  static final QueryField NOTE = QueryField(fieldName: "note");
  static final QueryField WEIGHTLBS = QueryField(fieldName: "weightLbs");
  static final QueryField REPS = QueryField(fieldName: "reps");
  static final QueryField DISTANCEMILES =
      QueryField(fieldName: "distanceMiles");
  static final QueryField DURATIONSECS = QueryField(fieldName: "durationSecs");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Set";
    modelSchemaDefinition.pluralName = "Sets";

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
        key: Set.EXERCISE,
        isRequired: true,
        targetName: "exerciseId",
        ofModelName: (Exercise).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Set.WORKOUT,
        isRequired: true,
        targetName: "workoutId",
        ofModelName: (Workout).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Set.EXECUTIONDATE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Set.NOTE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Set.WEIGHTLBS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Set.REPS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Set.DISTANCEMILES,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Set.DURATIONSECS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));
  });
}

class _SetModelType extends ModelType<Set> {
  const _SetModelType();

  @override
  Set fromJson(Map<String, dynamic> jsonData) {
    return Set.fromJson(jsonData);
  }
}
