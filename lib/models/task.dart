class Task {
  String uid;

  final String name;
  bool isDone;

  Task({required this.name, required this.isDone, required this.uid});

  void doneChange() {
    isDone = !isDone;
  }
}
