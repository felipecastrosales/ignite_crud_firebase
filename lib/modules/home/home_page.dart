import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:uuid/uuid.dart';

import 'store/home_page_store.dart';
import 'widget/task_input_field.dart';

import 'package:crud_firebase/shared/data/models/todo_item.dart';
import 'package:crud_firebase/shared/widgets/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _store = HomePageStore();
  final _toDoItemTitleEditingController = TextEditingController();

  @override
  void dispose() {
    _toDoItemTitleEditingController.dispose();
    super.dispose();
  }

  String undoneTaskQuantityMessage(int listLength) {
    final messageBodyPluralConcordance = listLength > 1 ? 'tarefas' : 'tarefa';
    final messageBody = listLength != 0 ? listLength.toString() : 'nenhuma';

    return '$messageBody $messageBodyPluralConcordance';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(177),
          child: Container(
            height: 177,
            color: const Color(0xFF8257E5),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Observer(
                  builder: (_) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 20,
                        ),
                      ),
                      Flexible(
                        child: Text.rich(
                          TextSpan(
                            text: 'Você tem ',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: undoneTaskQuantityMessage(
                                  _store.undoneTaskListLength,
                                ),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TaskInputField(
                  controller: _toDoItemTitleEditingController,
                  onTap: () {
                    _store.addItem(
                      ToDoItem(
                        id: const Uuid().v4(),
                        title: _toDoItemTitleEditingController.value.text,
                      ),
                    );

                    _toDoItemTitleEditingController.clear();
                  },
                ),
              ],
            ),
          ),
        ),
        body: Observer(
          builder: (_) => ToDoItemListView(
            itemList: _store.itemList,
            onDeleteItem: _store.deleteItem,
            toogleItemState: _store.toogleItemState,
          ),
        ),
      ),
    );
  }
}

class ToDoItemListView extends StatelessWidget {
  const ToDoItemListView({
    Key? key,
    required this.itemList,
    required this.onDeleteItem,
    required this.toogleItemState,
  }) : super(key: key);

  final ValueChanged<ToDoItem> onDeleteItem;
  final ValueChanged<ToDoItem> toogleItemState;
  final List<ToDoItem> itemList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemList.length,
      itemBuilder: (_, index) {
        final item = itemList[index];

        return Container(
          decoration: BoxDecoration(
            gradient: index.isEven
                ? const LinearGradient(
                    colors: [
                      Color(0xFFC4C4C4),
                      Color(0xFFFFFFFF),
                    ],
                  )
                : const LinearGradient(
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFFFF),
                    ],
                  ),
          ),
          child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              item.title,
              style: item.state == true
                  ? AppTextStyles.doneItemTextStyle
                  : AppTextStyles.undoneItemTextStyle,
            ),
            secondary: SizedBox(
              width: 80,
              child: GestureDetector(
                onTap: () => onDeleteItem(item),
                child: Image.asset(
                  'assets/images/delete.png',
                  height: 24,
                ),
              ),
            ),
            activeColor: Colors.green,
            value: item.state,
            onChanged: (_) => toogleItemState(item),
          ),
        );
      },
    );
  }
}
