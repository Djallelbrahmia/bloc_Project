import 'package:equatable/equatable.dart';

class Exercice extends Equatable {
  final String? title;
  final int? prelude;
  final int? duration;
  final int? index;
  final int? startTime;
  Exercice(
      {required this.title,
      required this.prelude,
      required this.duration,
      this.index,
      this.startTime});

  factory Exercice.fromJson(
          Map<String, dynamic> json, int index, int startTime) =>
      Exercice(
          title: json["title"],
          prelude: json["prelude"],
          duration: json["duration"],
          index: index,
          startTime: startTime);

  Map<String, dynamic> toJson() => {
        "title": title,
        "prelude": prelude,
        "duration": duration,
      };

  @override
  List<Object?> get props => [title, prelude, duration, index, startTime];
  Exercice copyWith(
          {int? prelude,
          String? title,
          int? duration,
          int? index,
          int? startTime}) =>
      Exercice(
          title: title ?? this.title,
          prelude: prelude ?? this.prelude,
          duration: duration ?? this.duration,
          index: this.index,
          startTime: this.startTime);
  @override
  bool? get stringify => true;
}
