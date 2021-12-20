import 'package:flutter/material.dart';
class TodoMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.red;
  final String title;
  final AppBar appBar;
  final List<Widget> widgets;

  const TodoMainAppBar({
    Key? key,
    required this.title,
    required this.appBar,
    required this.widgets,
  }) : super(key: key);

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
        IconButton(
            onPressed: () => {},
            icon: Icon(
              Icons.add_alert,
              color: Colors.black,
            ))
      ],
      leadingWidth: 40,
      leading: IconButton(
          onPressed: () => {},
          icon: Icon(
            Icons.apps,
            color: Colors.black,
          )),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}