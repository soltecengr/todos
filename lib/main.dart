import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_todo.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const OKToast(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        home: ListTodoScreen(),
      ),
    );
  }
}

class ListTodoScreen extends StatefulWidget {
  const ListTodoScreen({super.key});

  @override
  State<ListTodoScreen> createState() => _ListTodoScreenState();
}

class _ListTodoScreenState extends State<ListTodoScreen> {
  List todoList = [];

  @override
  void initState() {
    getTodoList();
    super.initState();
  }

  Future<void> getTodoList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String todos = prefs.getString('todos') ?? '[]';
    todoList = jsonDecode(todos);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var name = 'Soltec';
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('List Todo'),
        actions: [
          IconButton(
            onPressed: () {
              getTodoList();
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 16, top: 24, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What's up, $name",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Below are list of my activities today',
              style: TextStyle(fontSize: 16),
            ),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 8,
                    child: Container(
                      padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Business',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Divider(
                            color: Colors.purple,
                            thickness: 3,
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Colors.white,
                    elevation: 8,
                    child: Container(
                      padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Personal',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Divider(
                            color: Colors.blue,
                            thickness: 3,
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(' Today\'s Todo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                )),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RadioListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${todoList[index]['title']}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${todoList[index]['dueDate']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text('${todoList[index]['description']}'),
                          value: null,
                          groupValue: null,
                          onChanged: (val) {},
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CircleAvatar(
        radius: 24.0,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddTodo(),
              ),
            );
          },
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
