import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:todo_clean/app/data/models/todo.dart';
import 'package:todo_clean/app/global_widgets/TodoCard.dart';
import 'package:todo_clean/app/global_widgets/TodoMainAppBar.dart';
import 'package:todo_clean/app/modules/scenes/main/todo_controller.dart';
import 'package:todo_clean/app/modules/scenes/editor/Editor_Screen.dart';
import '../../../global_widgets/CapsuleTextField.dart';

class MainScreen extends StatelessWidget {
  final todoController = Get.put(TodoController());

  void _onNavigateToEditScreen(BuildContext context, Todo todo) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => Editor(
              todo: todo,
            ),
            fullscreenDialog: true
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TodoMainAppBar(appBar: AppBar(), widgets: [], title: "Todo"),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              CapsuleTextField(),
              Expanded(
                child: GetX<TodoController>(
                  builder: (controller) {
                    return Container(
                      padding: EdgeInsets.only(top: 20),
                      // child: ListView.separated(
                      //     separatorBuilder: (
                      //         BuildContext context,
                      //         int index
                      //         ) {
                      //       return Padding(
                      //           padding: const EdgeInsets.only(left: 20),
                      //           child: Divider(height: 1)
                      //       );
                      //     },
                      //     itemCount: controller.todos.length,
                      //     itemBuilder: (context, index) {
                      //       var todo = todoController.todos[index];
                      //       return TodoCard(
                      //         todo: todo,
                      //         onCheck: () {
                      //           todoController.checkItem(index);
                      //         },
                      //         itemIndex: index,
                      //         onPress: () => _onNavigateToEditScreen(context, todo),
                      //         onDismiss: () => todoController.removeTodo(id: todo.id),
                      //       );
                      //     }),
                      child: ImplicitlyAnimatedList<Todo>(
                        items: todoController.todos,
                        areItemsTheSame: (a, b) => a.id == b.id,
                        itemBuilder: (context, animation, item, index) {
                          var todo = todoController.todos[index];
                          return SizeFadeTransition(
                              sizeFraction: 0.4,
                              curve: Curves.easeInOut,
                              animation: animation,
                              child: TodoCard(
                                todo: todo,
                                onCheck: () {
                                  todoController.checkItem(index);
                                },
                                itemIndex: index,
                                onPress: () => _onNavigateToEditScreen(context, todo),
                                onDismiss: () => todoController.removeTodo(id: todo.id),
                              )
                          );
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.library_add),
            backgroundColor: Colors.red,
            splashColor: Colors.orange,
            elevation: 0,
            highlightElevation: 0,
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => Editor(), fullscreenDialog: true));
            }));
  }
}
