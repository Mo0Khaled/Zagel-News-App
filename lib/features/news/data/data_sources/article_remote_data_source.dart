import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleEntity>> getArticleByCategory(
      category_type category,
  );

  Future<List<ArticleEntity>> getArticleByQuery(String query);
}
