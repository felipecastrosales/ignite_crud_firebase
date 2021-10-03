class ToDoItem {
  ToDoItem({
    required this.id,
    required this.title,
    this.state = false,
  });

  final String id;
  final String title;
  final bool state;
}
