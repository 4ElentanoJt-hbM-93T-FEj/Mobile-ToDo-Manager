import 'package:flutter/material.dart';
import 'package:todo_locale_app/db/database.dart';
import 'package:todo_locale_app/provider/task/task_model.dart';
import 'package:todo_locale_app/widgets/addTask/add_task_modal_sheet.dart';
import 'package:todo_locale_app/widgets/dasboard/statistick_card.dart';
import 'package:todo_locale_app/widgets/item_task_card/task_item_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map<String, dynamic>> listTasks = [];
  int countOpenTask = 0;

  @override
  void initState() {
    getTasks();
    getCounts();
    super.initState();
  }

  Future<void> getCounts() async {
    var res = await DatabaseHelper.instance.getCountOpenTasks();
    countOpenTask = res.first.values.toList().first as int;
    setState(() {});
  }

  Future<void> getTasks() async {
    listTasks = await DatabaseHelper.instance.queryAllTasks();
    setState(() {});
    print(listTasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 90,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Мои задачи",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Активные задачи: $countOpenTask",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.style),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(color: Colors.grey[300]),
                  ),
                ),
              ],
            ),
          ],
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Colors.white),
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (int i = 0; i < 3; i++) ...[
                        StatistickCard(type: 'Тип', count: 0),
                      ],
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      for (var item in listTasks) ...[
                        TaskItemCard(id: item["id"], title: item["title"]),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(1, 1),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  useSafeArea: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return AddTaskWidget(
                      create: () async {
                        await getTasks();
                        await getCounts();
                      },
                    );
                  },
                );
              },
              child: Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(bottom: 30, right: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
