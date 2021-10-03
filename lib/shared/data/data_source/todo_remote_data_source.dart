import 'dart:async';

import 'package:crud_firebase/shared/data/models/todo_item.dart';
import 'package:crud_firebase/shared/data/todo_data_source_interface.dart';

class ToDoLocalDataSource implements ToDoDataSourceInterface {
  ToDoLocalDataSource() {
    streamController.stream.listen((itemList) {
      _actualItemList = itemList;
    });
  }

  final streamController = StreamController<List<ToDoItem>?>.broadcast();

  List<ToDoItem>? _actualItemList;

  @override
  Stream<List<ToDoItem>?> fetchToDoListStream() => streamController.stream;

  @override
  Future<void> onAddToDoItem(ToDoItem item) async {
    final itemList = _actualItemList ?? <ToDoItem>[];
    final newList = [...itemList, item];

    streamController.sink.add(newList);
  }

  @override
  Future<void> onRemoveToDoItem(String uid) async {
    final itemList = _actualItemList ?? <ToDoItem>[];

    final removableItem = itemList.singleWhere((item) => item.id == uid);

    final newList =
        itemList.where((item) => item.id != removableItem.id).toList();

    streamController.sink.add(newList);
  }

  @override
  Future<void> onToogleToDoItemState(String uid, bool state) async {
    final itemList = _actualItemList ?? <ToDoItem>[];

    final alterableItem = itemList.singleWhere((item) => item.id == uid);

    final newList = [
      ...itemList.where((item) => item.id != alterableItem.id).toList(),
      ToDoItem(id: alterableItem.id, title: alterableItem.title, state: state),
    ];

    streamController.sink.add(newList);
  }
}
