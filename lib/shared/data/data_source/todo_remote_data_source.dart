import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:crud_firebase/shared/data/models/todo_item.dart';
import 'package:crud_firebase/shared/data/todo_data_source_interface.dart';

class ToDoRemoteDataSource implements ToDoDataSourceInterface {
  final toDoCollection = FirebaseFirestore.instance.collection('toDos');

  @override
  Stream<List<ToDoItem>?> fetchToDoListStream() =>
      toDoCollection.snapshots().map<List<ToDoItem>>(
            (event) => event.docs
                .map((doc) => ToDoItem(
                      id: doc.id,
                      title: doc.data()['title'],
                      state: doc.data()['isDone'],
                    ))
                .toList(),
          );

  @override
  Future<void> onAddToDoItem(ToDoItem item) async {
    await toDoCollection.add(
      {
        'title': item.title,
        'isDone': item.state,
      },
    );
  }

  @override
  Future<void> onRemoveToDoItem(String uid) async {
    await toDoCollection.doc(uid).delete();
  }

  @override
  Future<void> onToogleToDoItemState(String uid, bool state) async {
    await toDoCollection.doc(uid).update({'isDone': state});
  }
}
