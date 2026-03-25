import 'package:equatable/equatable.dart';

class Story extends Equatable {
  const Story({
    required this.id,
    required this.title,
    required this.author,
    required this.score,
    required this.commentsCount,
    required this.time,
    required this.kids,
    this.url,
  });
  final int id;
  final String title;
  final String? url;
  final String author;
  final int score;
  final int commentsCount;
  final DateTime time;
  final List<int> kids;

  @override
  List<Object?> get props =>
      [id, title, url, author, score, commentsCount, time, kids];
}
