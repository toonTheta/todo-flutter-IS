import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {

  @JsonKey(required: true)
  String id;

  @JsonKey(required: true)
  String title;

  @JsonKey(defaultValue: "")
  String note;

  @JsonKey(defaultValue: false)
  bool isDone;

  @JsonKey(defaultValue: null)
  DateTime? date;

  Todo({
    required this.title,
    required this.id,
    this.isDone = false,
    this.note = "",
    this.date
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

}