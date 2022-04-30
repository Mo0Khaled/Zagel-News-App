import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zagel_news_app/core/constant/locale_db_keys.dart';
import 'package:zagel_news_app/core/exceptions/exceptions.dart';
import 'package:zagel_news_app/features/news/data/data_sources/article_locale_data_source.dart';
import 'package:zagel_news_app/features/news/data/models/article_model.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHive extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

const String articles = LocaleDbKeys.articleBox;

void main() {
  late ArticleLocaleDataSourceImpl articleLocaleDataSourceImpl;
  late MockHive mockHive;
  late MockHiveBox mockHiveBox;
  setUp(() async {
    mockHive = MockHive();
    await mockHive.initFlutter();

    mockHiveBox = MockHiveBox();
    articleLocaleDataSourceImpl = ArticleLocaleDataSourceImpl(hive: mockHive);
  });

  group("get last cached articles", () {
    final List<ArticleEntity> tArticlesList = [];
    final map = jsonDecode(fixture('cached_articles')) as Map<String, dynamic>;
    for (int i = 0; i < (map['articles'] as List).length; i++) {
      tArticlesList.add(
          ArticleModel.fromJson(map['articles'][i] as Map<String, dynamic>));
    }

    test(
        'should return the last cached articles from the hive when the cache is not empty',
        () async {
      // arrange
      when(() => mockHive.openBox(articles))
          .thenAnswer((_) async => mockHiveBox);
      when(() => mockHiveBox.get(articles)).thenReturn(jsonDecode(fixture('cached_articles')));
      // act
      final result = await articleLocaleDataSourceImpl.getArticleLocale();
      // assert
      verify(() =>mockHiveBox.get(articles)).called(1);
      expect(result, equals(tArticlesList));
    });


    test(
        'should throw a CacheException when there is no cached articles',
            () async {
          // arrange
          when(() => mockHive.openBox(articles))
              .thenAnswer((_) async => mockHiveBox);
          when(() => mockHiveBox.get(articles)).thenReturn(null);
          // act
          final call =  articleLocaleDataSourceImpl.getArticleLocale;
          // assert
          expect(() => call(), throwsA(isInstanceOf<CacheException>()));
        });
  });
}
