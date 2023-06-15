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

/** This is an auto generated class representing the Workout type in your schema. */
@immutable
class Workout extends Model {
  static const classType = const _WorkoutModelType();
  final String id;
  final List<Set> sets;
  final String note;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Workout._internal({@required this.id, @required this.sets, this.note});

  factory Workout({String id, @required List<Set> sets, String note}) {
    return Workout._internal(
        id: id == null ? UUID.getUUID() : id,
        sets: sets != null ? List.unmodifiable(sets) : sets,
        note: note);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Workout &&
        id == other.id &&
        DeepCollectionEquality().equals(sets, other.sets) &&
        note == other.note;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Workout {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("note=" + "$note");
    buffer.write("}");

    return buffer.toString();
  }

  Workout copyWith({String id, List<Set> sets, String note}) {
    return Workout(
        id: id ?? this.id, sets: sets ?? this.sets, note: note ?? this.note);
  }

  Workout.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        sets = json['sets'] is List
            ? (json['sets'] as List)
                .map((e) => Set.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        note = json['note'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'sets': sets?.map((e) => e?.toJson())?.toList(), 'note': note};

  static final QueryField ID = QueryField(fieldName: "workout.id");
  static final QueryField SETS = QueryField(
      fieldName: "sets",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Set).toString()));
  static final QueryField NOTE = QueryField(fieldName: "note");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Workout";
    modelSchemaDefinition.pluralName = "Workouts";

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

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Workout.SETS,
        isRequired: true,
        ofModelName: (Set).toString(),
        associatedKey: Set.WORKOUT));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Workout.NOTE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _WorkoutModelType extends ModelType<Workout> {
  const _WorkoutModelType();

  @override
  Workout fromJson(Map<String, dynamic> jsonData) {
    return Workout.fromJson(jsonData);
  }
}
