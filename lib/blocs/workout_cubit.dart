import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/models/exercise.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';
import 'package:flutter_bloc_app_complete/states/workout_states.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutIntial());
  editWorkout(Workout workout, int index) {
    return emit(WorkoutEditing(workout, index, null));
  }

  editExercice(int? exindex) {
    return emit(WorkoutEditing(
        state.workout, (state as WorkoutEditing).index, exindex));
  }

  void goHome() {
    emit(const WorkoutIntial());
  }
}
