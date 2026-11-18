import 'package:flutter/material.dart';
import '../models/task.dart';
import 'add_task_page.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [];

  int get _completedCount => _tasks.where((t) => t.isDone).length;
  int get _percent => (_progress * 100).round();

  double get _progress =>
      _tasks.isEmpty ? 0.0 : _completedCount / _tasks.length;

  Future<void> _openAddTask() async {
    final Task? newTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (_) => const AddTaskScreen()),
    );

    // Se l'utente rinuncia (back), newTask è null: nessuna modifica, nessun messaggio.
    if (newTask == null) return;

    setState(() => _tasks.add(newTask));

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Attività aggiunta'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _toggleDone(Task task) {
    setState(() => task.isDone = !task.isDone);
  }

  Future<void> _confirmDelete(Task task) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete activity?'),
        content: Text('"${task.title}" will be removed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Undo'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() => _tasks.remove(task));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2DO - Tracking'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress: $_completedCount / ${_tasks.length}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      '$_percent%',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _progress,
                    minHeight: 20,
                    color: const Color(0xFFEDDF59),
                    backgroundColor: const Color(0xFF3A3A3A),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _tasks.isEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'No activities',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8), // distanza tra i due testi
              const Text(
                'Press + to add a new one.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      )
          : ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return ListTile(
            leading: Checkbox(
              value: task.isDone,
              onChanged: (_) => _toggleDone(task),
            ),
            title: Text(
              task.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                decoration: task.isDone ? TextDecoration.lineThrough : null,
                color: task.isDone ? Colors.grey : null,
              ),
            ),
            subtitle: Text(task.isDone ? 'Done' : 'To do'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (task.isImportant)
                  const Icon(Icons.star, color: Colors.amber),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _confirmDelete(task),
                ),
              ],
            ),
            onTap: () => _toggleDone(task),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTask,
        tooltip: 'New activity',
        child: const Icon(Icons.add),
      ),
    );
  }
}