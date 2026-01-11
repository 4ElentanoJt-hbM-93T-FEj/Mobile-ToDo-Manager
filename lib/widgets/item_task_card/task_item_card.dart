import 'package:flutter/material.dart';

class TaskItemCard extends StatelessWidget {
  final int id;
  final String title;
  final String? description;
  // final DateTime dateTime;

  const TaskItemCard({
    super.key,
    required this.id,
    required this.title,
    // required this.dateTime,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
