import 'package:flutter/material.dart';

void main() {
  runApp(const EmadProjectApp());
}

class EmadProjectApp extends StatelessWidget {
  const EmadProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const TaskManagerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TaskManagerScreen extends StatefulWidget {
  const TaskManagerScreen({super.key});

  @override
  State<TaskManagerScreen> createState() => _TaskManagerScreenState();
}

class _TaskManagerScreenState extends State<TaskManagerScreen> {

  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Configurare ambiente macOS e Xcode', 'isDone': true},
    {'title': 'Superare i blocchi di Gatekeeper e Rete', 'isDone': true},
    {'title': 'Compilare l\'app su iPhone fisico', 'isDone': true},
    {'title': 'Sviluppare l\'interfaccia dell\'elaborato', 'isDone': true},
    {'title': 'Caricare il progetto finale su GitHub', 'isDone': false},
  ];

  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add({'title': _taskController.text, 'isDone': false});
      });
      _taskController.clear();
      Navigator.pop(context);
    }
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuova Attività'),
        content: TextField(
          controller: _taskController,
          decoration: const InputDecoration(hintText: 'Cosa devi fare?'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: _addTask,
            child: const Text('Aggiungi'),
          ),
        ],
      ),
    );
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['isDone'] = !_tasks[index]['isDone'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lino D'amora - Prima App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4,
      ),
      body: _tasks.isEmpty
          ? const Center(child: Text('Nessuna attività presente. Aggiungine una!', style: TextStyle(fontSize: 16)))
          : ListView.builder(
        padding: const EdgeInsets.only(top: 10, bottom: 80),
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Checkbox(
                value: task['isDone'],
                onChanged: (bool? value) {
                  _toggleTask(index);
                },
              ),
              title: Text(
                task['title'],
                style: TextStyle(
                  fontSize: 16,
                  decoration: task['isDone'] ? TextDecoration.lineThrough : null,
                  color: task['isDone'] ? Colors.grey : Colors.black87,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () => _deleteTask(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTaskDialog,
        icon: const Icon(Icons.add),
        label: const Text('Aggiungi'),
      ),
    );
  }
}