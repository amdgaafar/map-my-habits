import 'package:flutter/material.dart';
import 'package:map_my_habits/models/habit.dart';
import 'package:map_my_habits/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ManagePage> createState() => _ManagePage();
}

class _ManagePage extends State<ManagePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<Habit> _habits = [];

  late Store _store;
  bool hasBeenInitialized = false;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((dir) {
      _store = Store(
        getObjectBoxModel(),
        directory: join(dir.path, 'objectbox'),
      );

      setState(() {
        hasBeenInitialized = true;
      });
    });
    // _titleController.addListener(() {
    //   print('Title: ${_titleController.text}');
    // });
    // _descriptionController.addListener(() {
    //   print('Description: ${_descriptionController.text}');
    // });
  }

  @override
  void dispose() {
    _store.close();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: "Title",
                      hintText: "Enter a title",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a title";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: "Description",
                      hintText: "Enter a description",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a description";
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          final habit = Habit(
                            title: _titleController.text,
                            description: _descriptionController.text,
                          );
                          setState(() {
                            _store.box<Habit>().put(habit);
                          });
                          print('Habit added: ${habit.title}');
                        } else {
                          print('Form validation failed');
                        }
                      } else {
                        print('Form currentState is null');
                      }
                    },
                    child: const Text("Add Habit"),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: FutureBuilder<List<Habit>>(
              future: _getHabits(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final habits = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: habits.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(habits[index].title ?? ""),
                        subtitle: Text(habits[index].description ?? ""),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Habit>> _getHabits() async {
    final query = _store.box<Habit>();
    return query.getAll();
  }
}
