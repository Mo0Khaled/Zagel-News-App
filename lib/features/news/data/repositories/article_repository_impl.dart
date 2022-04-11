import 'package:dartz/dartz.dart';
import 'package:zagel_news_app/core/exceptions/failure.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  @override
  Future<Either<Failure, List<ArticleEntity>>> getArticleByCategory(category_type category) {
    // TODO: implement getArticleByCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getArticleByQuery(String query) {
    // TODO: implement getArticleByQuery
    throw UnimplementedError();
  }
  
}