import 'package:flutter/material.dart';
import 'package:todo_locale_app/db/database.dart';
import 'package:todo_locale_app/provider/task/task_model.dart';

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({super.key});

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  var nameController = TextEditingController();
  var decriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Создать задачу',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(children: [Text("Название", style: TextStyle(fontSize: 16))]),
            TextField(controller: nameController),
            SizedBox(height: 20),
            Row(children: [Text("Описание", style: TextStyle(fontSize: 16))]),
            TextField(controller: decriptionController, maxLines: 5),
            Expanded(child: SizedBox()),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text != "") {
                  try {
                    await DatabaseHelper.instance.insertTask(
                      Task(
                        title: nameController.text,
                        description: decriptionController.text,
                      ),
                    );
                  } catch (_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Ошибка создания задачи'),
                        backgroundColor: Colors.green,
                        elevation: 10,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                      ),
                    );
                  }
                  Navigator.pop(context);
                } else {}
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Создать",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
