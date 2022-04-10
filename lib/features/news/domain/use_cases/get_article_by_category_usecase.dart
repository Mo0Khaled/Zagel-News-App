import 'package:dartz/dartz.dart';
import 'package:zagel_news_app/core/exceptions/failure.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';

class GetArticleByCategoryUseCase {
  final ArticleRepository repository;

  GetArticleByCategoryUseCase(this.repository);
  Future<Either<Failure,List<ArticleEntity>>> call(category_type category) async {
    return repository.getArticleByCategory(category);
  }
}
