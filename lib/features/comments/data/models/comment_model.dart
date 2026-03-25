import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/comment.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
  const CommentModel({
    required this.id,
    required this.time,
    @JsonKey(name: 'by') this.author,
    this.text = '',
    this.kids = const [],
    this.parent,
  });

  final int id;
  final int time;
  final String? author;
  final String text;
  final List<int> kids;
  final int? parent;

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  Comment toEntity() {
    return Comment(
      id: id,
      author: author ?? '[deleted]',
      text: text,
      time: DateTime.fromMillisecondsSinceEpoch(time * 1000),
      kids: kids,
      parent: parent ?? 0,
    );
  }
}
