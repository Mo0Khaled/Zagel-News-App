import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String? author;
  final String title;
  final String description;
  final String urlToImage;
  final String publishedAt;
  final String? content;

  const ArticleEntity({
    required this.author,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  @override
  List<Object?> get props => [author, title, description, urlToImage, publishedAt, content];
}
