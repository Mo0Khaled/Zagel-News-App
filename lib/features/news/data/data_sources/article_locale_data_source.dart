import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:zagel_news_app/core/constant/locale_db_keys.dart';
import 'package:zagel_news_app/core/exceptions/exceptions.dart';
import 'package:zagel_news_app/features/news/data/models/article_model.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';

abstract class ArticleLocaleDataSource {
  Future<List<ArticleEntity>> getArticleLocale();

  Future<void> cacheArticleLocale(List<ArticleEntity> articles);

  Future<void> clearArticleLocaleCache();
}

class ArticleLocaleDataSourceImpl implements ArticleLocaleDataSource {
  final HiveInterface hive;

  ArticleLocaleDataSourceImpl({
    required this.hive,
  });

  @override
  Future<void> cacheArticleLocale(List<ArticleEntity> articles) {
    // TODO: implement cacheArticleLocale
    throw UnimplementedError();
  }

  @override
  Future<void> clearArticleLocaleCache() {
    // TODO: implement clearArticleLocaleCache
    throw UnimplementedError();
  }

  @override
  Future<List<ArticleEntity>> getArticleLocale() async {
    final box = await hive.openBox(LocaleDbKeys.articleBox);
    List<ArticleEntity> articles = [];
    final jsonArticles = (box.get(LocaleDbKeys.articleBox)
        as Map<String, dynamic>?)?['articles'];

    print(jsonArticles);
    if (jsonArticles != null) {
      articles = (jsonArticles as List<dynamic>)
          .map(
            (article) => ArticleModel.fromJson(article as Map<String, dynamic>),
          )
          .toList();
      return Future.value(articles);
    } else {
      throw CacheException();
    }
  }
}
