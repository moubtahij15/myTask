import 'package:flutter/material.dart';
import 'package:my_task/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:my_task/widgets/notification.dart';
import 'package:provider/provider.dart';


class TaskData extends ChangeNotifier {
  CollectionReference todosCollection =
      FirebaseFirestore.instance.collection("myTask");
  List<Task> tasks = [
    Task(name: 'go shopping', uid: "ZAA"),
    Task(name: 'buy a gift', uid: "ZAA"),
    Task(name: 'repair the car', uid: "ZAA"),
  ];

  Future addTask(String newTaskTitle,scheduleTime) async {
    NotificationApi().scheduleNotification(
        title: "It's time to do your task!",
        body: newTaskTitle,

        scheduledNotificationDateTime: scheduleTime);
    tasks.add(Task(name: newTaskTitle,uid: "ZAA"));
    notifyListeners();
    return await todosCollection.add({
      "title": newTaskTitle,
      "isComplet": false,
    });
  }

  void updateTask(Task task) {
    task.doneChange();
    notifyListeners();
  }

  void deleteTask(Task task) {
    tasks.remove(task);
    notifyListeners();
  }

  Future completTask(uid) async {
    await todosCollection.doc(uid).update({"isComplet": true});
  }

  Future removeTodo(uid) async {
    await todosCollection.doc(uid).delete();
  }

  List<Task> todoFromFirestore(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Task(
        name: e['title'] ?? '',
        isDone: false,
        uid: e.id,
      );
    }).toList();
  }

  Stream<List<Task>> listTodos() {
    return todosCollection.snapshots().map(todoFromFirestore);
  }
}
