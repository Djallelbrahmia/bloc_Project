// {
//         "title": "Forearm Plank",
//         "prelude": 5,
//         "duration": 180
//       }
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_app_complete/models/exercise.dart';

class Workout extends Equatable {
  final String? title;
  final List<Exercice> exercises;
  const Workout({required this.exercises, required this.title});
  factory Workout.fromJson(Map<String, dynamic> json) {
    List<Exercice> exercises = [];
    int index = 0;
    int startTime = 0;
    for (var ex in (json['exercises'] as Iterable)) {
      exercises.add(Exercice.fromJson(ex, index, startTime));
      index++;
      startTime += exercises.last.prelude! + exercises.last.duration!;
    }
    return Workout(exercises: exercises, title: json['title']);
  }
  Map<String, dynamic> toJson() => {"title": title, "exercises": exercises};
  int getTotal() {
    int time = exercises.fold(
        0, (previousValue, ex) => previousValue + ex.duration! + ex.prelude!);
    return time;
  }

  Exercice getCurrentExercice(int? elapsed) {
    return exercises.lastWhere((exercice) => exercice.startTime! <= elapsed!);
  }

  copyWith({String? title}) =>
      Workout(exercises: exercises, title: title ?? this.title);
  @override
  List<Object?> get props => [title, exercises];

  @override
  bool? get stringify => true;
}
