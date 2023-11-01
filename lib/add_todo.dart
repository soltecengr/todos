import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  late TextEditingController titleController;
  late TextEditingController desController;
  late DateTime? dueDate;

  @override
  void initState() {
    titleController = TextEditingController();
    desController = TextEditingController();
    dueDate = DateTime.now();
    super.initState();
  }

  Future<void> showDateTimePicker(BuildContext context) async {
    var initialDate = DateTime.now();
    dueDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    );
    showToast(
      '${dueDate?.day}-${dueDate?.month}-${dueDate?.year}',
      duration: const Duration(seconds: 5),
    );
  }

  Future<void> saveTask() async {
    Map<String, String> task = {
      'title': titleController.text,
      'description': desController.text,
      'dueDate': '${dueDate?.day}-${dueDate?.month}-${dueDate?.year}',
    };
    saveTodoToSharedPref(task);
  }

  Future<void> saveTodoToSharedPref(Map<String, String> task) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String todos = prefs.getString('todos') ?? '[]';
    List todoList = jsonDecode(todos);
    todoList.add(task);
    await prefs.setString('todos', jsonEncode(todoList));
    titleController.text = '';
    desController.text = '';
    showToast('Task has been saved successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const Text(
              'Add new task',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('Todo Title'),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: desController,
              maxLines: 3,
              decoration: const InputDecoration(
                label: Text('Todo Description'),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => showDateTimePicker(context),
              child: Row(
                children: const [
                  Icon(Icons.timer),
                  SizedBox(width: 8),
                  Text(
                    'Todo Due Date',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: saveTask,
              child: const Text('Save Todo'),
            )
          ],
        ),
      ),
    );
  }
}
