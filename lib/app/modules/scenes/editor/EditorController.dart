import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_clean/app/data/models/todo.dart';

class EditorController extends GetxController {

  var _title = "".obs;
  set title(String text) => _title.value = text;
  String get title => _title.value;

  var _note = "".obs;
  set note(String text) => _note.value = text;
  String get note => _note.value;

  var count = Rxn<int>();

  var _isEditMode = false;
  bool get isEditMode => _isEditMode;

  var _isDone = false;
  bool get isDone => _isDone;

  var _id = "";
  String get id => _id;

  // MARK: Date
  var _date = Rxn<DateTime>();
  set date(DateTime? newDate) => _date.value = newDate;
  DateTime? get date => _date.value;
  String get displayedDate {
    var dateFormatter = DateFormat('dd MMM yyyy');
    if (_date.value == null) return 'Date';
    return '${ dateFormatter.format(_date.value!)}';
  }

  var isTimeSet = false.obs;

  set time(TimeOfDay? newTime) {
    if (newTime == null) return;
    if (_date.value == null) return;
    isTimeSet.value = true;

    _date.value = DateTime(
      _date.value!.year,
      _date.value!.month,
      _date.value!.day,
      newTime.hour,
      newTime.minute,
    );

  }

  String get displayedTime {
    if (!isTimeSet.value) return "Time";
    var dateFormatter = DateFormat('HH:mm');
    if (_date.value == null) return '$TimeOfDay(hour: 0, minute: 0)';
    return dateFormatter.format(_date.value!);
  }

  void clear() {
    title = "";
    note = "";
    date = null;
    isTimeSet.value = false;
    _isDone = false;
    _isEditMode = false;
    _id = "";
  }

  // MARK: Set from exist `todo`
  void set({required Todo todo}) {
    title = todo.title;
    note = todo.note;
    _id = todo.id;
    _date.value = todo.date;
    _isDone = todo.isDone;
    _isEditMode = true;
  }

}