import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_clean/app/data/models/todo.dart';
import 'package:todo_clean/app/global_widgets/TodoEditorAppBar.dart';
import 'package:todo_clean/app/modules/scenes/editor/EditorController.dart';
import 'package:todo_clean/app/modules/scenes/main/todo_controller.dart';

class Editor extends StatelessWidget {

  Editor({Todo? todo}) {
    if (todo == null) return;
    editorController.set(todo: todo);
  }

  final TodoController todoController = Get.find();
  final EditorController editorController = Get.put(EditorController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  void onSave(BuildContext context) {
    if (editorController.isEditMode) {
      todoController.editTodo(
          id: editorController.id,
          title: editorController.title,
          note:  editorController.note,
          date:  editorController.date,
          isDone: editorController.isDone
      );
      print("Here");
    } else {
      todoController.createTodo(
          editorController.title,
          editorController.note,
          editorController.date
      );
    }
    editorController.clear();
    Navigator.pop(context);
  }

  void onTitleChange(String text) {
    editorController.title = text;
  }

  void onNoteChange(String text) {
    editorController.note = text;
  }

  void handleShowDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    ).then((date) => editorController.date = date);
  }

  void handleShowTimePicker(BuildContext context) {
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    ).then((value) => editorController.time = value);
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = editorController.title;
    noteController.text = editorController.note;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: new Size.fromHeight(AppBar().preferredSize.height),
          child: Obx(() {
            return TodoEditorAppBar(
              appBar: AppBar(),
              title: "Create",
              widgets: [],
              onSave: () {
                this.onSave(context);
              },
              onCancel: () {
                editorController.clear();
              },
              enabled: editorController.title.isNotEmpty,
            );
          }),
        ),
        body: Container(
          color: Colors.grey[100],
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  children: [
                    Hero(
                      tag: editorController.id,
                      child: Material(
                        color: Colors.transparent,
                        child: TextField(
                          controller: titleController,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintMaxLines: 1,
                            hintText: "Title",
                            border: InputBorder.none,
                          ),
                          onChanged: onTitleChange,
                        ),
                      ),
                    ),
                    Divider(),
                    TextField(
                      controller: noteController,
                      decoration: InputDecoration(
                        hintMaxLines: 1,
                        hintText: "Notes",
                        border: InputBorder.none,
                      ),
                      onChanged: onNoteChange,
                      minLines: 3,
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.event, size: 24, color: Colors.redAccent,),
                          SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              handleShowDatePicker(context);
                            },
                            child: Obx(() {
                              return Text('${editorController.displayedDate}');
                            }),
                            style: TextButton.styleFrom(
                                primary: Colors.grey
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Icon(Icons.schedule, size: 24, color: Colors.redAccent,),
                          SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              handleShowTimePicker(context);
                            },
                            child: Obx(() {
                              return Text('${editorController.displayedTime}');
                            }),
                            style: TextButton.styleFrom(
                                primary: Colors.grey
                            ),
                          )
                        ],
                      ),
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }
}
