import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/time_formatter.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  const Comment({
    required this.id,
    required this.time,
    @JsonKey(name: 'by') this.author,
    this.text = '',
    this.kids = const [],
    this.parent,
    this.replies = const [],
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  final int id;
  final int time;
  @JsonKey(name: 'by')
  final String? author;
  final String text;
  final List<int> kids;
  final int? parent;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<Comment> replies;

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  DateTime get dateTime => DateTimeUtils.fromUnix(time);
  String get displayAuthor => author ?? '[deleted]';

  Comment copyWith({List<Comment>? replies}) {
    return Comment(
      id: id,
      time: time,
      author: author,
      text: text,
      kids: kids,
      parent: parent,
      replies: replies ?? this.replies,
    );
  }
}
