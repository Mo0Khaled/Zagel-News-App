import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:zagel_news_app/core/constant/app_strings.dart';
import 'package:zagel_news_app/core/exceptions/exceptions.dart';
import 'package:zagel_news_app/features/news/data/models/article_model.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleEntity>> getArticleByCategory(
    category_type category,
  );

  Future<List<ArticleEntity>> getArticleByQuery(String query);
}

class ArticleRemoteDataSourceImpl extends ArticleRemoteDataSource {
  final Dio dio;

  ArticleRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ArticleEntity>> getArticleByCategory(
      category_type category) async {

    final baseUrl = "$BASE_URL&category=${category.name}&apiKey=$NEWS_API_KEY";
    return getArticles(baseUrl);
  }

  @override
  Future<List<ArticleEntity>> getArticleByQuery(String query) {
    final baseUrl =
        "https://newsapi.org/v2/everything?q=$query&sortBy=popularity&&apiKey=$NEWS_API_KEY";
    return getArticles(baseUrl);
  }

  Future<List<ArticleEntity>> getArticles(String url) async {
    final baseUrl = url;
    final response = await dio.get(baseUrl);
    final List<ArticleEntity> articlesList = [];

      if (response.statusCode == 200) {
        final jsonArticlesList =
            (response.data  as Map<String,dynamic>)['articles'];
        for (final jsonArticle in jsonArticlesList) {
          articlesList
              .add(ArticleModel.fromJson(jsonArticle as Map<String, dynamic>));
        }
        return articlesList;
      } else {
        throw ServerException();
      }
    }
}
