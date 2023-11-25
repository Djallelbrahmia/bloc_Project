import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/blocs/workouts_cubit.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';
import 'package:flutter_bloc_app_complete/screens/edit_workout_screen.dart';
import 'package:flutter_bloc_app_complete/screens/home_screen.dart';
import 'package:flutter_bloc_app_complete/states/workout_states.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(WorkoutTime());
}

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "My Workouts",
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
          textTheme: const TextTheme(
              bodyText2: TextStyle(color: Color.fromARGB(255, 66, 74, 96))),
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<WorkoutsCubit>(
              create: (BuildContext context) {
                WorkoutsCubit workoutsCubit = WorkoutsCubit();
                if (workoutsCubit.state.isEmpty) {
                  workoutsCubit.getWorkouts();
                }
                return workoutsCubit;
              },
            ),
            BlocProvider<WorkoutCubit>(
              create: (BuildContext context) {
                WorkoutCubit workoutCubit = WorkoutCubit();

                return workoutCubit;
              },
            ),
          ],
          child: BlocBuilder<WorkoutCubit, WorkoutState>(
            builder: (context, state) {
              if (state is WorkoutIntial) {
                return const HomePage();
              } else if (state is WorkoutEditing) {
                return EditWorkoutScreen();
              }
              return Container();
            },
          ),
        ));
  }
}
