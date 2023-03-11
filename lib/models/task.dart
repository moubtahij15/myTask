class Task {
  String uid;

  final String name;
  bool isDone;

  Task({required this.name, this.isDone = true, required this.uid});

  void doneChange() {
    isDone = !isDone;
  }
}
