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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Exercise type in your schema. */
@immutable
class Exercise extends Model {
  static const classType = const _ExerciseModelType();
  final String id;
  final String name;
  final bool isStrength;
  final List<ExerciseCategoryExercise> categories;
  final List<RoutineExercise> routines;
  final String note;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Exercise._internal(
      {@required this.id,
      @required this.name,
      @required this.isStrength,
      @required this.categories,
      @required this.routines,
      this.note});

  factory Exercise(
      {String id,
      @required String name,
      @required bool isStrength,
      @required List<ExerciseCategoryExercise> categories,
      @required List<RoutineExercise> routines,
      String note}) {
    return Exercise._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        isStrength: isStrength,
        categories:
            categories != null ? List.unmodifiable(categories) : categories,
        routines: routines != null ? List.unmodifiable(routines) : routines,
        note: note);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Exercise &&
        id == other.id &&
        name == other.name &&
        isStrength == other.isStrength &&
        DeepCollectionEquality().equals(categories, other.categories) &&
        DeepCollectionEquality().equals(routines, other.routines) &&
        note == other.note;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Exercise {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("isStrength=" +
        (isStrength != null ? isStrength.toString() : "null") +
        ", ");
    buffer.write("note=" + "$note");
    buffer.write("}");

    return buffer.toString();
  }

  Exercise copyWith(
      {String id,
      String name,
      bool isStrength,
      List<ExerciseCategoryExercise> categories,
      List<RoutineExercise> routines,
      String note}) {
    return Exercise(
        id: id ?? this.id,
        name: name ?? this.name,
        isStrength: isStrength ?? this.isStrength,
        categories: categories ?? this.categories,
        routines: routines ?? this.routines,
        note: note ?? this.note);
  }

  Exercise.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        isStrength = json['isStrength'],
        categories = json['categories'] is List
            ? (json['categories'] as List)
                .map((e) => ExerciseCategoryExercise.fromJson(
                    new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        routines = json['routines'] is List
            ? (json['routines'] as List)
                .map((e) =>
                    RoutineExercise.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        note = json['note'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'isStrength': isStrength,
        'categories': categories?.map((e) => e?.toJson())?.toList(),
        'routines': routines?.map((e) => e?.toJson())?.toList(),
        'note': note
      };

  static final QueryField ID = QueryField(fieldName: "exercise.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField ISSTRENGTH = QueryField(fieldName: "isStrength");
  static final QueryField CATEGORIES = QueryField(
      fieldName: "categories",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (ExerciseCategoryExercise).toString()));
  static final QueryField ROUTINES = QueryField(
      fieldName: "routines",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (RoutineExercise).toString()));
  static final QueryField NOTE = QueryField(fieldName: "note");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Exercise";
    modelSchemaDefinition.pluralName = "Exercises";

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

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Exercise.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Exercise.ISSTRENGTH,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Exercise.CATEGORIES,
        isRequired: true,
        ofModelName: (ExerciseCategoryExercise).toString(),
        associatedKey: ExerciseCategoryExercise.EXERCISE));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Exercise.ROUTINES,
        isRequired: true,
        ofModelName: (RoutineExercise).toString(),
        associatedKey: RoutineExercise.EXERCISE));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Exercise.NOTE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _ExerciseModelType extends ModelType<Exercise> {
  const _ExerciseModelType();

  @override
  Exercise fromJson(Map<String, dynamic> jsonData) {
    return Exercise.fromJson(jsonData);
  }
}
