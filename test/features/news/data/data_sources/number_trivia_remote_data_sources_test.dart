import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zagel_news_app/core/constant/app_strings.dart';
import 'package:zagel_news_app/core/exceptions/exceptions.dart';
import 'package:zagel_news_app/features/news/data/data_sources/article_remote_data_source.dart';
import 'package:zagel_news_app/features/news/data/models/article_model.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements dio.Dio {}

void main() {
  late MockDio mockDio;
  late ArticleRemoteDataSourceImpl dataSource;
  setUp(() {
    mockDio = MockDio();
    dataSource = ArticleRemoteDataSourceImpl(dio: mockDio);
  });
  final List<ArticleEntity> tArticlesList = [];
  final map = jsonDecode(fixture('cached_articles')) as Map<String, dynamic>;
  for (int i = 0; i < (map['articles'] as List).length; i++) {
    tArticlesList
        .add(ArticleModel.fromJson(map['articles'][i] as Map<String, dynamic>));
  }
  const tCategory = category_type.sports;
  final baseUrlForCategory =
      "$BASE_URL&category=$tCategory&apiKey=$NEWS_API_KEY";
  void setUpMockDioClientSuccess200(String url) {
    when(() => mockDio.get(url)).thenAnswer(
      (_) async => dio.Response(
        data: fixture('articles'),
        statusCode: 200,
        requestOptions: RequestOptions(
          baseUrl: url,
          path: url,
        ),
      ),
    );
  }

  void setUpMockDioClientFailure404(String url) {
    when(() => mockDio.get(url)).thenAnswer(
      (_) async => dio.Response(
        data: "someThingWentWrong",
        statusCode: 400,
        requestOptions: RequestOptions(
          baseUrl: url,
          path: url,
        ),
      ),
    );
  }

  group("getArticleByCategory", () {
    test(
        'should get a list of articles from the endpoint if server returns a 200',
        () async {
      // arrange
      setUpMockDioClientSuccess200(baseUrlForCategory);
      // act
      final result = await dataSource.getArticleByCategory(tCategory);
      // assert
      verify(() => mockDio.get(baseUrlForCategory)).called(1);
      expect(result, equals(tArticlesList));
    });

    test('should throw a ServerException if the server returns a 400 or higher',
        () async {
      // arrange
      setUpMockDioClientFailure404(baseUrlForCategory);
      // act
      final call = dataSource.getArticleByCategory;
      // assert
      expect(() => call(tCategory), throwsA(isInstanceOf<ServerException>()));
    });
  });

  group("getArticleByQuery", () {

    const query = "ronaldo";
    const baseUrlForQuery =
        "https://newsapi.org/v2/everything?q=$query&sortBy=popularity&&apiKey=$NEWS_API_KEY";
    test(
        'should get a list of articles from the endpoint if server returns a 200',
        () async {
      // arrange
      setUpMockDioClientSuccess200(baseUrlForQuery);
      // act
      final result = await dataSource.getArticleByQuery(query);
      // assert
      verify(() => mockDio.get(baseUrlForQuery)).called(1);
      expect(result, equals(tArticlesList));
    });

    test('should throw a ServerException if the server returns a 400 or higher',
        () async {
      // arrange
      setUpMockDioClientFailure404(baseUrlForQuery);
      // act
      final call = dataSource.getArticleByQuery;
      // assert
      expect(() => call(query), throwsA(isInstanceOf<ServerException>()));
    });
  });
}
