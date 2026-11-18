class Task {
  final String title;
  final bool isImportant;
  bool isDone;

  Task({
    required this.title,
    this.isImportant = false,
    this.isDone = false,
  });
}