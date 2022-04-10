import 'package:dartz/dartz.dart';
import 'package:zagel_news_app/core/exceptions/failure.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';

enum category_type {
  all,
  business,
  entertainment,
  general,
  health,
  science,
  sports,
  technology,
}

abstract class ArticleRepository {
  Future<Either<Failure, ArticleEntity>> getArticleByCategory(
      category_type category);

  Future<Either<Failure, ArticleEntity>> getArticleByQuery(String query);
}
