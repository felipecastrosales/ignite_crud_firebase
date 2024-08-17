// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageStore on HomePageStoreBase, Store {
  Computed<List<ToDoItem>>? _$itemListComputed;

  @override
  List<ToDoItem> get itemList =>
      (_$itemListComputed ??= Computed<List<ToDoItem>>(() => super.itemList,
              name: 'HomePageStoreBase.itemList'))
          .value;
  Computed<int>? _$undoneTaskListLengthComputed;

  @override
  int get undoneTaskListLength => (_$undoneTaskListLengthComputed ??=
          Computed<int>(() => super.undoneTaskListLength,
              name: 'HomePageStoreBase.undoneTaskListLength'))
      .value;

  late final _$toDoListStreamAtom =
      Atom(name: 'HomePageStoreBase.toDoListStream', context: context);

  @override
  ObservableStream<List<ToDoItem>?> get toDoListStream {
    _$toDoListStreamAtom.reportRead();
    return super.toDoListStream;
  }

  @override
  set toDoListStream(ObservableStream<List<ToDoItem>?> value) {
    _$toDoListStreamAtom.reportWrite(value, super.toDoListStream, () {
      super.toDoListStream = value;
    });
  }

  @override
  String toString() {
    return '''
toDoListStream: ${toDoListStream},
itemList: ${itemList},
undoneTaskListLength: ${undoneTaskListLength}
    ''';
  }
}
