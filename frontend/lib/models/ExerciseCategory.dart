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

/** This is an auto generated class representing the ExerciseCategory type in your schema. */
@immutable
class ExerciseCategory extends Model {
  static const classType = const _ExerciseCategoryModelType();
  final String id;
  final String name;
  final ExerciseCategory parentCategory;
  final List<ExerciseCategoryExercise> exercises;
  final String note;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const ExerciseCategory._internal(
      {@required this.id,
      @required this.name,
      this.parentCategory,
      @required this.exercises,
      this.note});

  factory ExerciseCategory(
      {String id,
      @required String name,
      ExerciseCategory parentCategory,
      @required List<ExerciseCategoryExercise> exercises,
      String note}) {
    return ExerciseCategory._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        parentCategory: parentCategory,
        exercises: exercises != null ? List.unmodifiable(exercises) : exercises,
        note: note);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExerciseCategory &&
        id == other.id &&
        name == other.name &&
        parentCategory == other.parentCategory &&
        DeepCollectionEquality().equals(exercises, other.exercises) &&
        note == other.note;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("ExerciseCategory {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("parentCategory=" +
        (parentCategory != null ? parentCategory.toString() : "null") +
        ", ");
    buffer.write("note=" + "$note");
    buffer.write("}");

    return buffer.toString();
  }

  ExerciseCategory copyWith(
      {String id,
      String name,
      ExerciseCategory parentCategory,
      List<ExerciseCategoryExercise> exercises,
      String note}) {
    return ExerciseCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        parentCategory: parentCategory ?? this.parentCategory,
        exercises: exercises ?? this.exercises,
        note: note ?? this.note);
  }

  ExerciseCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        parentCategory = json['parentCategory'] != null
            ? ExerciseCategory.fromJson(
                new Map<String, dynamic>.from(json['parentCategory']))
            : null,
        exercises = json['exercises'] is List
            ? (json['exercises'] as List)
                .map((e) => ExerciseCategoryExercise.fromJson(
                    new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        note = json['note'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'parentCategory': parentCategory?.toJson(),
        'exercises': exercises?.map((e) => e?.toJson())?.toList(),
        'note': note
      };

  static final QueryField ID = QueryField(fieldName: "exerciseCategory.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField PARENTCATEGORY = QueryField(
      fieldName: "parentCategory",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (ExerciseCategory).toString()));
  static final QueryField EXERCISES = QueryField(
      fieldName: "exercises",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (ExerciseCategoryExercise).toString()));
  static final QueryField NOTE = QueryField(fieldName: "note");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ExerciseCategory";
    modelSchemaDefinition.pluralName = "ExerciseCategories";

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
        key: ExerciseCategory.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: ExerciseCategory.PARENTCATEGORY,
        isRequired: false,
        targetName: "parentCategoryId",
        ofModelName: (ExerciseCategory).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: ExerciseCategory.EXERCISES,
        isRequired: true,
        ofModelName: (ExerciseCategoryExercise).toString(),
        associatedKey: ExerciseCategoryExercise.EXERCISECATEGORY));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ExerciseCategory.NOTE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _ExerciseCategoryModelType extends ModelType<ExerciseCategory> {
  const _ExerciseCategoryModelType();

  @override
  ExerciseCategory fromJson(Map<String, dynamic> jsonData) {
    return ExerciseCategory.fromJson(jsonData);
  }
}
