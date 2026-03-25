import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/story.dart';

part 'story_model.g.dart';

@JsonSerializable()
class StoryModel {
  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
  const StoryModel({
    required this.id,
    required this.title,
    @JsonKey(name: 'by') required this.author,
    required this.score,
    required this.time,
    this.url,
    @JsonKey(name: 'descendants') this.commentsCount = 0,
    this.kids = const [],
  });

  final int id;
  final String title;
  @JsonKey(name: 'by')
  final String author;
  final int score;
  final int time;
  final String? url;
  @JsonKey(name: 'descendants')
  final int commentsCount;
  final List<int> kids;

  Map<String, dynamic> toJson() => _$StoryModelToJson(this);

  Story toEntity() {
    return Story(
      id: id,
      title: title,
      url: url,
      author: author,
      score: score,
      commentsCount: commentsCount,
      time: DateTime.fromMillisecondsSinceEpoch(time * 1000),
      kids: kids,
    );
  }
}
