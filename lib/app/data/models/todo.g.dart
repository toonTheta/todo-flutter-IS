// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'title'],
  );
  return Todo(
    title: json['title'] as String,
    id: json['id'] as String,
    isDone: json['isDone'] as bool? ?? false,
    note: json['note'] as String? ?? '',
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  );
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'note': instance.note,
      'isDone': instance.isDone,
      'date': instance.date?.toIso8601String(),
    };
