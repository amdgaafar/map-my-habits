import 'package:flutter/material.dart';
import 'package:map_my_habits/models/habit.dart';
import 'package:map_my_habits/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DailyCheckPage extends StatefulWidget {
  const DailyCheckPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  // _DailyCheckPageState createState() => _DailyCheckPageState();
  State<DailyCheckPage> createState() => _DailyCheckPageState();
}

class _DailyCheckPageState extends State<DailyCheckPage> {
  final List<String> tasks = ['Task 1', 'Task 2', 'Task 3'];

  final Map<String, bool> checkedTasks = {};

  late Store _store;
  Box<Habit>? _taskBox;
  bool hasBeenInitialized = false;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((dir) => {
          _store = Store(
            getObjectBoxModel(),
            directory: join(dir.path, 'objectbox'),
          ),
        });

    setState(() {
      hasBeenInitialized = true;
    });

    for (String task in tasks) {
      checkedTasks[task] = false;
    }
  }

  @override
  void dispose() {
    _store.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            leading: Checkbox(
              value: checkedTasks[task],
              onChanged: (checked) {
                setState(() {
                  checkedTasks[task] = checked ?? false;
                });
              },
            ),
            title: Text(task),
          );
        },
      ),
    );
  }
}
