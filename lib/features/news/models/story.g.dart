// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) => Story(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  author: json['by'] as String,
  score: (json['score'] as num).toInt(),
  time: (json['time'] as num).toInt(),
  url: json['url'] as String?,
  commentsCount: (json['descendants'] as num?)?.toInt() ?? 0,
  kids:
      (json['kids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
);

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'by': instance.author,
  'score': instance.score,
  'time': instance.time,
  'url': instance.url,
  'descendants': instance.commentsCount,
  'kids': instance.kids,
};
