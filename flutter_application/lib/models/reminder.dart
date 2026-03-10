import 'package:flutter/foundation.dart';

@immutable
class Reminder {
  final String title;
  final String message;
  final DateTime dueDate;
  final String severity;

  const Reminder({
    required this.title,
    required this.message,
    required this.dueDate,
    required this.severity,
  });
}
