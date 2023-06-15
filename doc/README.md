# API Documentation
## Query

getExerciseCategory(id: ID!): ExerciseCategory
**Description**: Get an ExerciseCategory given its ID
**Response**: ExerciseCategory fields
**Example**:
```
query MyQuery {
  getExerciseCategory(id: "qwertyuiop") {
    id
  }
}
```

listExerciseCategorys(
filter: ModelExerciseCategoryFilterInput
id: ID
limit: Int
nextToken: String
sortDirection: ModelSortDirection
): ModelExerciseCategoryConnection
**Description**: Get a list of all exercise categories
**Response**: [ExerciseCategory]
**Example**:
```
query MyQuery {
  listExerciseCategorys {
    items {
      name
      id
    }
  }
}
```

getExercise(id: ID!): Exercise
**Description**: Get an Exercise given its ID
**Response**: Exercise fields
**Example**:
```
query MyQuery {
  getExercise(id: "qwertyuiop") {
    id
    name
  }
}
```

listExercises(
filter: ModelExerciseFilterInput
id: ID
limit: Int
nextToken: String
sortDirection: ModelSortDirection
): ModelExerciseConnection
**Description**: Get a list of all exercises
**Response**: [Exercise]
**Example**:
```
query MyQuery {
  listExercises {
    items {
      id
      name
    }
  }
}
```

getWorkout(id: ID!): Workout
**Description**: Get a Workout given its ID
**Response**: Workout fields
**Example**:
```
query MyQuery {
  getWorkout(id: "qwertyuiop") {
    id
  }
}
```

listWorkouts(
filter: ModelWorkoutFilterInput
id: ID
limit: Int
nextToken: String
sortDirection: ModelSortDirection
): ModelWorkoutConnection
**Description**: Get a list of all workouts
**Response**: [Workout]
**Example**:
```
query MyQuery {
  listWorkouts {
    items {
      id
    }
  }
}
```

getRoutine(id: ID!): Routine
**Description**: Get a Routine given its ID
**Response**: Routine fields
**Example**:
```
query MyQuery {
  getRoutine(id: "qwertyuiop") {
    id
    name
  }
}
```

listRoutines(
filter: ModelRoutineFilterInput
id: ID
limit: Int
nextToken: String
sortDirection: ModelSortDirection
): ModelRoutineConnection
**Description**: Get a list of all routines
**Response**: [Routine]
**Example**:
```
query MyQuery {
  listRoutines {
    items {
      id
      name
    }
  }
}
```

getSet(id: ID!): Set
**Description**: Get a Set given its ID
**Response**: Set fields
**Example**:
```
query MyQuery {
  getSet(id: "qwertyuiop") {
    id
    distanceMiles
    executionDate
    durationSecs
    reps
    weightLbs
  }
}
```

listSets(
filter: ModelSetFilterInput
id: ID
limit: Int
nextToken: String
sortDirection: ModelSortDirection
): ModelSetConnection
**Description**: Get a list of all sets
**Response**: [Set]
**Example**:
```
query MyQuery {
  listSets {
    items {
      id
      weightLbs
      reps
      durationSecs
      distanceMiles
      executionDate
      exerciseId
    }
  }
}
```

categoriesByName(
filter: ModelExerciseCategoryFilterInput
limit: Int
name: String
nextToken: String
sortDirection: ModelSortDirection
): ModelExerciseCategoryConnection
**Description**: Get a list of categories that has the given name
**Response**: [ExerciseCategory]
**Example**:
```
query MyQuery {
  categoriesByName(name: "CategoryName") {
    items {
      id
      name
    }
  }
}
```

categoriesByParent(
filter: ModelExerciseCategoryFilterInput
limit: Int
nextToken: String
parentCategoryId: ID
sortDirection: ModelSortDirection
): ModelExerciseCategoryConnection
**Description**: Get a list of categories that has the given parent category ID
**Response**: [ExerciseCategory]
**Example**:
```
query MyQuery {
  categoriesByParent(parentCategoryId: "qwertyuiop") {
    items {
      id
      name
    }
  }
}
```

exercisesByName(
filter: ModelExerciseFilterInput
limit: Int
name: String
nextToken: String
sortDirection: ModelSortDirection
): ModelExerciseConnection
**Description**: Get a list of exercises that has the given name
**Response**: [Exercise]
**Example**:
```
query MyQuery {
  exercisesByName(name: "Benchpress") {
    items {
      name
      id
    }
  }
}
```

exercisesByExerciseCategory(
exerciseCategoryId: ID
exerciseId: ModelIDKeyConditionInput
filter: ModelExerciseCategoryExerciseFilterInput
limit: Int
nextToken: String
sortDirection: ModelSortDirection
): ModelExerciseCategoryExerciseConnection
**Description**: Get a list of exercises that belongs to the given category
**Response**: [ExerciseCategoryExercise]
**Example**:
```
query MyQuery {
  exercisesByExerciseCategory(exerciseCategoryId: "qwertyuiop") {
    items {
      id
      exerciseId
      exerciseCategoryId
    }
  }
}
```

exerciseCategoriesByExercise(
exerciseCategoryId: ModelIDKeyConditionInput
exerciseId: ID
filter: ModelExerciseCategoryExerciseFilterInput
limit: Int
nextToken: String
sortDirection: ModelSortDirection
): ModelExerciseCategoryExerciseConnection
**Description**: Get a list of categories that contain the given exercise
**Response**: [ExerciseCategoryExercise]
**Example**:
```
query MyQuery {
  exerciseCategoriesByExercise(exerciseId: "qwertyuiop") {
    items {
      id
      exerciseId
      exerciseCategoryId
    }
  }
}
```

routinesByName(
filter: ModelRoutineFilterInput
limit: Int
name: String
nextToken: String
sortDirection: ModelSortDirection
): ModelRoutineConnection
**Description**: Get a list of routines that has the given name
**Response**: [Routine]
**Example**:
```
query MyQuery {
  routinesByName(name: "RoutineName") {
    items {
      name
      id
    }
  }
}
```

setsByExercise(
exerciseId: ID
filter: ModelSetFilterInput
limit: Int
nextToken: String
sortDirection: ModelSortDirection
): ModelSetConnection
**Description**: Get a list of sets that has the given exerciseId
**Response**: [Set]
**Example**:
```
query MyQuery {
  setsByExercise(exerciseId: "qwertyuiop") {
    items {
      id
      exerciseId
      distanceMiles
      durationSecs
      reps
      weightLbs
    }
  }
}
```

setsByWorkout(
filter: ModelSetFilterInput
limit: Int
nextToken: String
sortDirection: ModelSortDirection
workoutId: ID
): ModelSetConnection
**Description**: Get a list of sets that has the given workoutId
**Response**: [Set]
**Example**:
```
query MyQuery {
  setsByWorkout(workoutId: "qwertyuiop") {
    items {
      id
      durationSecs
      distanceMiles
      exerciseId
      reps
      weightLbs
    }
  }
}
```

## Mutation
createExerciseCategory(condition: ModelExerciseCategoryConditionInputinput: 
CreateExerciseCategoryInput!): ExerciseCategory
**Description**: Create an exercise category given a name
**Response**: ExerciseCategory type
**Example**:
```
mutation MyMutation {
  createExerciseCategory(input: {name: "CategoryName"}) {
    id
  }
}
```

updateExerciseCategory(condition: ModelExerciseCategoryConditionInputinput: UpdateExerciseCategoryInput!): ExerciseCategory
**Description**: Update an ExerciseCategory's fields given its ID and new values
**Response**: Exercise type
**Example**:
```
mutation MyMutation {
  updateExerciseCategory(input: {id: "qwertyuiop", name: "NewName"}) {
    id
  }
}
```

deleteExerciseCategory(condition: ModelExerciseCategoryConditionInputinput: DeleteExerciseCategoryInput!): ExerciseCategory
**Description**: Delete an exercise category given its ID
**Response**: ExerciseCategory type
**Example**:
```
mutation MyMutation {
  deleteExerciseCategory(input: {id: "qwerty"}) {
    id
  }
}
```

createExercise(condition: ModelExerciseConditionInputinput: CreateExerciseInput!): Exercise
**Description**: Create an exercise given a name and if it's a strength type exercise
**Response**: Exercise type
**Example**:
```
mutation MyMutation {
  createExercise(input: {name: "Sprint", isStrength: false}) {
    id
  }
}
```

updateExercise(condition: ModelExerciseConditionInputinput: UpdateExerciseInput!): Exercise
**Description**: Update an Exercise's fields given its ID and new values
**Response**: Exercise type
**Example**:
```
mutation MyMutation {
  updateExercise(input: {id: "qwertyuiop", name: "NewName"}) {
    id
  }
}

```

deleteExercise(condition: ModelExerciseConditionInputinput: DeleteExerciseInput!): Exercise
**Description**: Delete an exercise given its ID
**Response**: Exercise type
**Example**:
```
mutation MyMutation {
  deleteExercise(input: {id: "qwerty"}) {
    id
  }
}
```

createExerciseCategoryExercise(condition: ModelExerciseCategoryExerciseConditionInputinput: 
CreateExerciseCategoryExerciseInput!): ExerciseCategoryExercise
**Description**: Create a connection between an exercise and a category
**Response**: ExerciseCategoryExercise type
**Example**:
```
mutation MyMutation {
  createExerciseCategoryExercise(
    input: {exerciseCategoryId: "qwerty", exerciseId: "213456"}
  ) {
    id
  }
}
```

updateExerciseCategoryExercise(condition: ModelExerciseCategoryExerciseConditionInputinput: UpdateExerciseCategoryExerciseInput!): ExerciseCategoryExercise
**Description**: Update an ExerciseCategoryExercise's fields given its ID and new values
**Response**: ExerciseCategoryExercise type
**Example**:
```
mutation MyMutation {
  updateExerciseCategoryExercise(
    input: {id: "qwertyuiop", exerciseCategoryId: "newId",
    exerciseId: "newId"}
  ) {
    id
  }
}
```

deleteExerciseCategoryExercise(condition: ModelExerciseCategoryExerciseConditionInputinput: DeleteExerciseCategoryExerciseInput!): ExerciseCategoryExercise
**Description**: Delete the connection between an exercise and a category given its ID
**Response**: ExerciseCategoryExercise type
**Example**:
```
mutation MyMutation {
  deleteExerciseCategoryExercise(input: {id: "qwertyuiop"}) {
    id
  }
}
```

createRoutineExercise(condition: ModelRoutineExerciseConditionInputinput: CreateRoutineExerciseInput!): RoutineExercise
**Description**: Create a connection between a routine and a category
**Response**: RoutineExercise type
**Example**:
```
mutation MyMutation {
  createRoutineExercise(input: {routineId: "qwertyu",
  exerciseId: "123456"}) {
    id
  }
}
```

updateRoutineExercise(condition: ModelRoutineExerciseConditionInputinput: UpdateRoutineExerciseInput!): RoutineExercise
**Description**: Update a RoutineExercise's fields given its ID and new values
**Response**: RoutineExercise type
**Example**:
```
mutation MyMutation {
  updateRoutineExercise(
    input: {id: "qwerty", exerciseId: "newId", routineId: "newId"}
  ) {
    id
  }
}
```

deleteRoutineExercise(condition: ModelRoutineExerciseConditionInputinput: DeleteRoutineExerciseInput!): RoutineExercise
**Description**: Delete the connection between an exercise and a routine given its ID
**Response**: RoutineExercise type
**Example**:
```
mutation MyMutation {
  deleteRoutineExercise(input: {id: "qwertyu"}) {
    id
  }
}
```

createWorkout(condition: ModelWorkoutConditionInputinput: CreateWorkoutInput!): Workout
**Description**: Create a workout
**Response**: Workout type
**Example**:
```
mutation MyMutation {
  createWorkout(input: {}) {
    id
  }
}
```

updateWorkout(condition: ModelWorkoutConditionInputinput: UpdateWorkoutInput!): Workout
**Description**: Update a Workout's fields given its ID and new values
**Response**: Workout type
**Example**:
```
mutation MyMutation {
  updateWorkout(input: {id: "qwertyuiop", note: "Notes"}) {
    id
  }
}
```

deleteWorkout(condition: ModelWorkoutConditionInputinput: DeleteWorkoutInput!): Workout
**Description**: Delete a workout given its ID
**Response**: Workout type
**Example**:
```
mutation MyMutation {
  deleteWorkout(input: {id: "qwerty"}) {
    id
  }
}
```

createRoutine(condition: ModelRoutineConditionInputinput: CreateRoutineInput!): Routine
**Description**: Create a routine given a name
**Response**: Routine type
**Example**:
```
mutation MyMutation {
  createRoutine(input: {name: "Routine"}) {
    id
  }
}
```

updateRoutine(condition: ModelRoutineConditionInputinput: UpdateRoutineInput!): Routine
**Description**: Update a Routine's fields given its ID and new values
**Response**: Routine type
**Example**:
```
mutation MyMutation {
  updateRoutine(input: {id: "qwertyui", name: "NewName"}) {
    id
  }
}
```

deleteRoutine(condition: ModelRoutineConditionInputinput: DeleteRoutineInput!): Routine
**Description**: Delete a routine given its ID
**Response**: Routine type
**Example**:
```
mutation MyMutation {
  deleteRoutine(input: {id: "qwerty"}) {
    id
  }
}
```

createSet(condition: ModelSetConditionInputinput: CreateSetInput!): Set
**Description**: Create a set given a workoutId, exerciseId, and executionDate
**Response**: Set type
**Example**:
```
mutation MyMutation {
  createSet(
    input: {exerciseId: "qwerqwer", workoutId: "weqrty5",
    executionDate: "04/11/2021"}
  ) {
    id
  }
}
```


updateSet(condition: ModelSetConditionInputinput: UpdateSetInput!): Set
**Description**: Update a Set's fields given its ID and new values
**Response**: Set type
**Example**:
```
mutation MyMutation {
  updateSet(input: {id: "qwerty", durationSecs: 20}) {
    id
  }
}
```

deleteSet(condition: ModelSetConditionInputinput: DeleteSetInput!): Set
**Description**: Delete a Set given its ID
**Response**: Set type
**Example**:
```
mutation MyMutation {
  deleteSet(input: {id: "qwertyui"}) {
    id
  }
}
```
