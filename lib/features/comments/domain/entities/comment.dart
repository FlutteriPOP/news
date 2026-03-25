import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  const Comment({
    required this.id,
    required this.author,
    required this.text,
    required this.time,
    required this.kids,
    required this.parent,
    this.replies = const [],
  });
  final int id;
  final String author;
  final String text;
  final DateTime time;
  final List<int> kids;
  final int parent;
  final List<Comment> replies;

  Comment copyWith({List<Comment>? replies}) {
    return Comment(
      id: id,
      author: author,
      text: text,
      time: time,
      kids: kids,
      parent: parent,
      replies: replies ?? this.replies,
    );
  }

  @override
  List<Object?> get props => [id, author, text, time, kids, parent, replies];
}
