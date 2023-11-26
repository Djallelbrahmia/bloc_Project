import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/blocs/workouts_cubit.dart';
import 'package:flutter_bloc_app_complete/helpers/helpers.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout Time !"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.event_available)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
          builder: (context, workouts) {
            return ExpansionPanelList.radio(
              children: workouts
                  .map(
                    (workout) => ExpansionPanelRadio(
                      value: workout,
                      headerBuilder: (BuildContext context, isExpanded) =>
                          ListTile(
                        visualDensity: const VisualDensity(
                          horizontal: 0,
                          vertical: VisualDensity.maximumDensity,
                        ),
                        leading: IconButton(
                          onPressed: () {
                            BlocProvider.of<WorkoutCubit>(context).editWorkout(
                                workout, workouts.indexOf(workout));
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        trailing: Text(formatTime(workout.getTotal(), true)),
                        title: Text(workout.title!),
                        onTap: () {
                          if (!isExpanded) {
                            BlocProvider.of<WorkoutCubit>(context)
                                .startWorkout(workout);
                          }
                        },
                      ),
                      body: ListView.builder(
                          shrinkWrap: true,
                          itemCount: workout.exercises.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              visualDensity: const VisualDensity(
                                horizontal: 0,
                                vertical: VisualDensity.maximumDensity,
                              ),
                              leading: Text(formatTime(
                                  workout.exercises[index].prelude!, true)),
                              title: Text(workout.exercises[index].title!),
                              trailing: Text(formatTime(
                                  workout.exercises[index].duration!, true)),
                            );
                          }),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
