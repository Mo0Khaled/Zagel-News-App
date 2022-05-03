import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    required String? author,
    required String? title,
    required String? description,
    required String? urlToImage,
    required String? publishedAt,
    required String? content,
  }) : super(
          author: author,
          title: title,
          description: description,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        author: json['author'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        urlToImage: json['urlToImage'] as String?,
        publishedAt: json['publishedAt'] as String?,
        content: json['content'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'author': author,
        'title': title,
        'description': description,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt,
        'content': content,
      };
}
