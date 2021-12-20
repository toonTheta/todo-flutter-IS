import 'package:flutter/material.dart';
class TodoEditorAppBar extends StatelessWidget implements PreferredSizeWidget {

  final Color backgroundColor = Colors.red;
  final String title;
  final AppBar appBar;
  final List<Widget> widgets;
  final Function()? onSave;
  final Function()? onCancel;
  final bool enabled;

  const TodoEditorAppBar({
    Key? key,
    required this.title,
    required this.appBar,
    required this.widgets,
    this.enabled = true,
    this.onSave,
    this.onCancel,
  }) : super(key: key);

  void handleOnSave(BuildContext context) {
    if (this.onSave != null) {
      this.onSave!();
    }
    hideKeyboardIfNeed(context);
  }

  void handleOnCancel(BuildContext context) {
    if (this.onCancel != null) this.onCancel!();
    hideKeyboardIfNeed(context);
    Navigator.pop(context);
  }

  void hideKeyboardIfNeed(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        this.title,
        style: TextStyle(color: Colors.black),
        textAlign: TextAlign.start,
      ),
      centerTitle: false,
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      actions: [
        TextButton(onPressed: this.enabled ? () => handleOnSave(context) : null, child: Text("Save"))
        // Text("Save")
      ],
      leadingWidth: 60,
      leading: IconButton(
          onPressed: () => { this.handleOnCancel(context) },
          icon: Icon(
            Icons.close,
            color: Colors.black,
          )),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}