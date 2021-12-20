import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_clean/app/data/models/todo.dart';
import 'package:todo_clean/app/global_widgets/Touchable.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final Function()? onCheck;
  final Function()? onPress;
  final Function()? onDismiss;
  final int itemIndex;

  const TodoCard({
    Key? key,
    required this.todo,
    required this.itemIndex,
    this.onCheck,
    this.onPress,
    this.onDismiss,
  }) : super(key: key);

  void handleOnCheck() {
    print("handleOnCheck");
    if (this.onCheck == null) {
      return;
    }
    onCheck!();
  }

  Widget _swipeLeftActionWidget() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        color: Colors.green,
        child: Icon(Icons.cancel)
    );
  }

  Widget _swipeRightActionWidget() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(Icons.cancel, color: Colors.white,)
    );
  }

  Widget _title() {
    return Hero(
      tag: todo.id,
      child: Material(
        color: Colors.transparent,
        child: TextField(
          controller: TextEditingController(text: todo.title),
          enabled: false,
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      background: _swipeRightActionWidget(),
      onDismissed: (direction) {
        if (onDismiss != null) onDismiss!();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Touchable(
          onPress: () {
            if (onPress != null) onPress!();
          },
          borderRadius: 5,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Checkbox(
                  value: this.todo.isDone,
                  onChanged: (checked) {
                    this.handleOnCheck();
                  }),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _title(),
                    Visibility(
                      visible: this.todo.note.length != 0,
                      child: Text(
                        this.todo.note,
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                    Visibility(
                      visible: this.todo.date != null,
                      child: Text(
                        this.todo.date.toString(),
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
