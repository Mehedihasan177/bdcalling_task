import 'package:intl/intl.dart';

class TodoList {
  final DateTime? date;
  final String? note;
  final String? startTime;
  final String? endTime;
  final String? id;
  final String? title;
  bool? isComplete;

  TodoList({
    required this.date,
    required this.note,
    required this.startTime,
    required this.endTime,
    required this.id,
    required this.title,
    required this.isComplete,
  });

  factory TodoList.fromJson(Map<String, dynamic> json) {
    return TodoList(
      date: DateTime.tryParse(json['date'] ?? ''),
      note: json['note'] ?? '',
      startTime: json['startTime'] ,
      endTime: json['endTime'],
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      isComplete: json['isComplete'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': DateFormat('M/d/yyyy h:mm a').format(date!),
      'note': note,
      'startTime': startTime,
      'endTime': endTime,
      'id': id,
      'title': title,
      'isComplete': isComplete,
    };
  }
}
