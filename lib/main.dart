import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      home: ListTodoScreen(),
    );
  }
}

class ListTodoScreen extends StatelessWidget {
  const ListTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var name = 'Soltec';
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Todo'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          const SizedBox(height: 32),
          Text(
            "What's up, $name",
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
      floatingActionButton: CircleAvatar(
        radius: 24.0,
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
