import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  late TextEditingController titleController;
  late TextEditingController desController;

  @override
  void initState() {
    titleController = TextEditingController();
    desController = TextEditingController();
    super.initState();
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
                label: Text('Todo Tiele'),
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
              onTap: () {
                showToast('On tapping this widget the clock widget will show');
              },
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
              onPressed: () {
                showToast(
                  'Todo has been saved successfully',
                  duration: const Duration(seconds: 1),
                );
              },
              child: const Text('Save Todo'),
            )
          ],
        ),
      ),
    );
  }
}
