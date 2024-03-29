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

  Future<void> _initStore() async {
    final dir = await getApplicationDocumentsDirectory();
    _store = Store(
      getObjectBoxModel(),
      directory: join(dir.path, 'objectbox'),
    );
    setState(() {
      hasBeenInitialized = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _initStore();
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
      body: FutureBuilder<List<Habit>>(
        future: _getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final habits = snapshot.data ?? [];
            return ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                final habit = habits[index];
                return ListTile(
                  title: Text(habit.title!),
                  subtitle: Text(habit.description!),
                  trailing: Checkbox(
                    value: habit.habitRecords.any((record) => record.isDone),
                    onChanged: (value) {
                      setState(() {
                        final record = HabitRecord(
                          date: DateTime.now(),
                          isDone: value!,
                          habit: habit,
                        );
                        habit.habitRecords.add(record);
                        _store.box<HabitRecord>().put(record);
                      });
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Habit>> _getTasks() async {
    final query = _store.box<Habit>();
    return query.getAll();
  }
}
