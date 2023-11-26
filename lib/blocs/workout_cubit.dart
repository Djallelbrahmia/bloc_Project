import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';
import 'package:flutter_bloc_app_complete/states/workout_states.dart';
import 'package:wakelock/wakelock.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutIntial());
  Timer? _timer;
  onTick(Timer time) {
    if (state is WorkoutInProgress) {
      WorkoutInProgress wp = state as WorkoutInProgress;
      if (wp.elapsed! < wp.workout!.getTotal()) {
        print("my elapsed time is ${wp.elapsed}");
        emit(WorkoutInProgress(wp.workout, wp.elapsed! + 1));
      } else {
        _timer!.cancel();
        Wakelock.disable();
        emit(const WorkoutIntial());
      }
    }
  }

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

  void pauseWorkout() {
    emit(WorkoutPaused(state.workout, state.elapsed));
  }

  resumeWorkout() => emit(WorkoutInProgress(state.workout, state.elapsed));

  void startWorkout(Workout workout, [int? index]) {
    Wakelock.enable();
    if (index != null) {
    } else {
      emit(WorkoutInProgress(workout, 0));
    }
    _timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }
}
