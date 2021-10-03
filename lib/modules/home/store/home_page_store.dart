import 'package:crud_firebase/shared/data/data_source/todo_remote_data_source.dart';
import 'package:crud_firebase/shared/data/todo_data_source_interface.dart';
import 'package:mobx/mobx.dart';

import 'package:crud_firebase/shared/data/models/todo_item.dart';

part 'home_page_store.g.dart';

class HomePageStore = _HomePageStore with _$HomePageStore;

abstract class _HomePageStore with Store {
  static final ToDoDataSourceInterface _toDoRemoteDS = ToDoLocalDataSource();

  @observable
  var toDoListStream = _toDoRemoteDS.fetchToDoListStream().asObservable();

  Future<void> toogleItemState(ToDoItem oldItem) async {
    await _toDoRemoteDS.onToogleToDoItemState(oldItem.id, !oldItem.state);
  }

  Future<void> addItem(ToDoItem item) async {
    await _toDoRemoteDS.onAddToDoItem(item);
  }

  Future<void> deleteItem(ToDoItem item) async {
    await _toDoRemoteDS.onRemoveToDoItem(item.id);
  }

  @computed
  List<ToDoItem> get itemList {
    final sortedItemList = toDoListStream.value
      ?..sort((a, b) => a.state ? 1 : -1);

    return sortedItemList ?? <ToDoItem>[];
  }

  @computed
  int get undoneTaskListLength =>
      itemList.where((item) => item.state == false).length;
}
