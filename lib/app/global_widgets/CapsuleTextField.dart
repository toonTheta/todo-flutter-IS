import 'package:flutter/material.dart';

class CapsuleTextField extends StatelessWidget {
  final Function(String)? onChanges;
  const CapsuleTextField({
    Key? key,
    this.onChanges,
  }) : super(key: key);

  void handleTextChange(String text) {
    if (onChanges != null) {
      onChanges!(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(100)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
              fillColor: Colors.red,
              border: InputBorder.none,
              hintText: "Search",
            ),
            onChanged: (text) => {handleTextChange(text)},
          ),
        ),
      ),
    );
  }
}