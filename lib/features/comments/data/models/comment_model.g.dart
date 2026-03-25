// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
  id: (json['id'] as num).toInt(),
  time: (json['time'] as num).toInt(),
  author: json['by'] as String?,
  text: json['text'] as String? ?? '',
  kids:
      (json['kids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  parent: (json['parent'] as num?)?.toInt(),
);

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time,
      'by': instance.author,
      'text': instance.text,
      'kids': instance.kids,
      'parent': instance.parent,
    };
