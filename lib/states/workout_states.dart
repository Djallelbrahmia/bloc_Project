import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';

abstract class WorkoutState extends Equatable {
  final Workout? workout;
  final int? elapsed;
  const WorkoutState(this.workout, this.elapsed);
}

class WorkoutIntial extends WorkoutState {
  const WorkoutIntial() : super(null, 0);
  @override
  List<Object?> get props => [];
}

class WorkoutEditing extends WorkoutState {
  const WorkoutEditing(Workout? workout, this.index, this.exIndex)
      : super(workout, 0);
  final int index;
  final int? exIndex;

  @override
  List<Object?> get props => [workout, index, exIndex];
}

class WorkoutInProgress extends WorkoutState {
  const WorkoutInProgress(Workout? workout, int? elapsed)
      : super(workout, elapsed);
  @override
  List<Object?> get props => [workout, elapsed];
}

class WorkoutPaused extends WorkoutState {
  const WorkoutPaused(Workout? workout, int? elapsed) : super(workout, elapsed);

  @override
  List<Object?> get props => [workout, elapsed];
}
