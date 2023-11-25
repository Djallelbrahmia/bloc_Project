import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/helpers/helpers.dart';
import 'package:flutter_bloc_app_complete/models/exercise.dart';
import 'package:flutter_bloc_app_complete/screens/edit_exercice_screen.dart';
import 'package:flutter_bloc_app_complete/states/workout_states.dart';

class EditWorkoutScreen extends StatelessWidget {
  const EditWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: BlocBuilder<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        if (state is WorkoutEditing) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  BlocProvider.of<WorkoutCubit>(context).goHome();
                },
              ),
            ),
            body: ListView.builder(
                itemCount: state.workout!.exercises.length,
                itemBuilder: (context, index) {
                  Exercice exercice = state.workout!.exercises[index];
                  if (state.exIndex == index) {
                    return EditExecriceScreen(
                      workout: state.workout,
                      index: state.index,
                      exIndex: index,
                    );
                  } else {
                    return ListTile(
                      leading: Text(formatTime(exercice.prelude!, true)),
                      title: Text(exercice.title!),
                      trailing: Text(formatTime(exercice.duration!, true)),
                      onTap: (() {
                        BlocProvider.of<WorkoutCubit>(context)
                            .editExercice(index);
                      }),
                    );
                  }
                }),
          );
        } else {
          return Container();
        }
      },
    ), onWillPop: () async {
      return true;
    });
  }
}
