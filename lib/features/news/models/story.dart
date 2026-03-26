import 'package:json_annotation/json_annotation.dart';
import '../../../../core/utils/time_formatter.dart';

part 'story.g.dart';

@JsonSerializable()
class Story {
  const Story({
    required this.id,
    required this.title,
    @JsonKey(name: 'by') required this.author,
    required this.score,
    required this.time,
    this.url,
    @JsonKey(name: 'descendants') this.commentsCount = 0,
    this.kids = const [],
  });

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

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

  Map<String, dynamic> toJson() => _$StoryToJson(this);

  DateTime get dateTime => DateTimeUtils.fromUnix(time);
}
