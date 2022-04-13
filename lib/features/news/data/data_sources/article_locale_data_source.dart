import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';

abstract class ArticleLocaleDataSource {
  Future<List<ArticleEntity>> getArticleLocale(String articleId);
  Future<void> cacheArticleLocale(List<ArticleEntity> articles);
  Future<void> clearArticleLocaleCache();
}
