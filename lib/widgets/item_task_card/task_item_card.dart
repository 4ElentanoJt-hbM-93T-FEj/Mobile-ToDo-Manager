import 'package:flutter/material.dart';

class TaskItemCard extends StatelessWidget {
  final int id;
  final String title;
  final String? description;

  const TaskItemCard({
    super.key,
    required this.id,
    required this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 100),
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  Expanded(child: Text(title, overflow: TextOverflow.ellipsis)),
                  SizedBox(width: 5),
                  Icon(Icons.keyboard_option_key_sharp),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
