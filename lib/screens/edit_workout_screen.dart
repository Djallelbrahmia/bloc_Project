import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/blocs/workouts_cubit.dart';
import 'package:flutter_bloc_app_complete/helpers/helpers.dart';
import 'package:flutter_bloc_app_complete/models/exercise.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';
import 'package:flutter_bloc_app_complete/screens/edit_exercice_screen.dart';
import 'package:flutter_bloc_app_complete/states/workout_states.dart';

class EditWorkoutScreen extends StatefulWidget {
  const EditWorkoutScreen({super.key});

  @override
  State<EditWorkoutScreen> createState() => _EditWorkoutScreenState();
}

class _EditWorkoutScreenState extends State<EditWorkoutScreen> {
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
              title: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        final controller =
                            TextEditingController(text: state.workout!.title);
                        return AlertDialog(
                          content: TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                                labelText: "Workout title"),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  if (controller.text.isNotEmpty) {
                                    Navigator.pop(context);

                                    Workout renamed = state.workout!
                                        .copyWith(title: controller.text);
                                    setState(() {
                                      BlocProvider.of<WorkoutsCubit>(context)
                                          .saveWorkout(renamed, state.index);
                                      BlocProvider.of<WorkoutCubit>(context)
                                          .editWorkout(renamed, state.index);
                                    });
                                  }
                                },
                                child: Text("Save"))
                          ],
                        );
                      });
                },
                child: Text(state.workout!.title!),
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
