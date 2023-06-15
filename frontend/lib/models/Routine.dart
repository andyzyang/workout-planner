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

/** This is an auto generated class representing the Routine type in your schema. */
@immutable
class Routine extends Model {
  static const classType = const _RoutineModelType();
  final String id;
  final String name;
  final List<RoutineExercise> exercises;
  final String note;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Routine._internal(
      {@required this.id,
      @required this.name,
      @required this.exercises,
      this.note});

  factory Routine(
      {String id,
      @required String name,
      @required List<RoutineExercise> exercises,
      String note}) {
    return Routine._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        exercises: exercises != null ? List.unmodifiable(exercises) : exercises,
        note: note);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Routine &&
        id == other.id &&
        name == other.name &&
        DeepCollectionEquality().equals(exercises, other.exercises) &&
        note == other.note;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Routine {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("note=" + "$note");
    buffer.write("}");

    return buffer.toString();
  }

  Routine copyWith(
      {String id, String name, List<RoutineExercise> exercises, String note}) {
    return Routine(
        id: id ?? this.id,
        name: name ?? this.name,
        exercises: exercises ?? this.exercises,
        note: note ?? this.note);
  }

  Routine.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        exercises = json['exercises'] is List
            ? (json['exercises'] as List)
                .map((e) =>
                    RoutineExercise.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        note = json['note'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'exercises': exercises?.map((e) => e?.toJson())?.toList(),
        'note': note
      };

  static final QueryField ID = QueryField(fieldName: "routine.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField EXERCISES = QueryField(
      fieldName: "exercises",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (RoutineExercise).toString()));
  static final QueryField NOTE = QueryField(fieldName: "note");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Routine";
    modelSchemaDefinition.pluralName = "Routines";

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
        key: Routine.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Routine.EXERCISES,
        isRequired: true,
        ofModelName: (RoutineExercise).toString(),
        associatedKey: RoutineExercise.ROUTINE));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Routine.NOTE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _RoutineModelType extends ModelType<Routine> {
  const _RoutineModelType();

  @override
  Routine fromJson(Map<String, dynamic> jsonData) {
    return Routine.fromJson(jsonData);
  }
}
