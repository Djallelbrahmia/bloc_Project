import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workouts_cubit.dart';
import 'package:flutter_bloc_app_complete/helpers/helpers.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';
import 'package:numberpicker/numberpicker.dart';

class EditExecriceScreen extends StatefulWidget {
  final Workout? workout;
  final int index;
  final int? exIndex;

  const EditExecriceScreen(
      {Key? key, this.workout, required this.index, this.exIndex})
      : super(key: key);

  @override
  State<EditExecriceScreen> createState() => _EditExecriceScreenState();
}

class _EditExecriceScreenState extends State<EditExecriceScreen> {
  TextEditingController? _titleController;
  @override
  void initState() {
    _titleController = TextEditingController(
        text: widget.workout!.exercises[widget.exIndex!].title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex: 1,
                child: InkWell(
                  onLongPress: (() => showDialog(
                      context: context,
                      builder: (_) {
                        final controller = TextEditingController(
                            text: widget
                                .workout!.exercises[widget.exIndex!].prelude!
                                .toString());
                        return AlertDialog(
                          content: TextField(
                            controller: controller,
                            decoration:
                                InputDecoration(labelText: "Prelude (seconds)"),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  if (controller.text.isNotEmpty) {
                                    Navigator.pop(context);
                                    setState(() {
                                      widget.workout!
                                              .exercises[widget.exIndex!] =
                                          widget.workout!
                                              .exercises[widget.exIndex!]
                                              .copyWith(
                                                  prelude: int.parse(
                                                      controller.text));
                                    });
                                    BlocProvider.of<WorkoutsCubit>(context)
                                        .saveWorkout(
                                            widget.workout!, widget.index);
                                  }
                                },
                                child: const Text("Save"))
                          ],
                        );
                      })),
                  child: NumberPicker(
                    minValue: 0,
                    maxValue: 3599,
                    value: widget.workout!.exercises[widget.exIndex!].prelude!,
                    onChanged: (value) {
                      setState(() {
                        widget.workout!.exercises[widget.exIndex!] = widget
                            .workout!.exercises[widget.exIndex!]
                            .copyWith(prelude: value);
                      });
                      BlocProvider.of<WorkoutsCubit>(context)
                          .saveWorkout(widget.workout!, widget.index);
                    },
                    itemHeight: 30,
                    textMapper: (strVal) {
                      return formatTime(int.parse(strVal), false);
                    },
                  ),
                )),
            Expanded(
              flex: 4,
              child: TextField(
                textAlign: TextAlign.center,
                controller: _titleController,
                onChanged: (value) {
                  setState(() {
                    widget.workout!.exercises[widget.exIndex!] = widget
                        .workout!.exercises[widget.exIndex!]
                        .copyWith(title: value);
                  });
                  BlocProvider.of<WorkoutsCubit>(context)
                      .saveWorkout(widget.workout!, widget.index);
                },
              ),
            ),
            Expanded(
                flex: 1,
                child: InkWell(
                  onLongPress: (() => showDialog(
                      context: context,
                      builder: (_) {
                        final controller = TextEditingController(
                            text: widget
                                .workout!.exercises[widget.exIndex!].duration!
                                .toString());
                        return AlertDialog(
                          content: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                                labelText: "Duratiom (seconds)"),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  if (controller.text.isNotEmpty) {
                                    Navigator.pop(context);
                                    setState(() {
                                      widget.workout!
                                              .exercises[widget.exIndex!] =
                                          widget.workout!
                                              .exercises[widget.exIndex!]
                                              .copyWith(
                                                  duration: int.parse(
                                                      controller.text));
                                    });
                                    BlocProvider.of<WorkoutsCubit>(context)
                                        .saveWorkout(
                                            widget.workout!, widget.index);
                                  }
                                },
                                child: const Text("Save"))
                          ],
                        );
                      })),
                  child: NumberPicker(
                    minValue: 0,
                    maxValue: 3599,
                    value: widget.workout!.exercises[widget.exIndex!].duration!,
                    onChanged: (value) {
                      setState(() {
                        widget.workout!.exercises[widget.exIndex!] = widget
                            .workout!.exercises[widget.exIndex!]
                            .copyWith(duration: value);
                      });
                      BlocProvider.of<WorkoutsCubit>(context)
                          .saveWorkout(widget.workout!, widget.index);
                    },
                    itemHeight: 30,
                    textMapper: (strVal) {
                      return formatTime(int.parse(strVal), false);
                    },
                  ),
                )),
          ],
        )
      ],
    );
  }
}
