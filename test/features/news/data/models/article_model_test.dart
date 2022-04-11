import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:zagel_news_app/features/news/data/models/article_model.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const ArticleModel tArticleModel = ArticleModel(
    title: 'title',
    description: 'description',
    urlToImage: 'urlToImage',
    publishedAt: 'publishedAt',
    content: 'content',
    author: 'author',
  );

  test('should be as subclass of [Article Entity]', () async {
    // assert
    expect(tArticleModel, isA<ArticleEntity>());
  });

  group("from json test", () {
    const List<ArticleEntity> tArticleList = [
      ArticleModel(
          author: "Ben Morse, CNN",
          title:
              "Scottie Scheffler wins 2022 Masters, the first major of his career, following dominant performance - CNN",
          description:
              "Scottie Scheffler won the 2022 Masters on Sunday following a dominant performance at Augusta National.",
          urlToImage:
              "https://cdn.cnn.com/cnnnext/dam/assets/220410183110-01-scottie-scheffler-masters-winner-2022-super-tease.jpg",
          publishedAt: "2022-04-10T23:50:00Z",
          content: "content"),
      ArticleModel(
          author: null,
          title:
              "27 states report rise in COVID infections in past 8 days - CBS Evening News",
          description:
              "In California, COVID cases are up 78% in the last four days, but there has been no increase in the critical number of hospitalizations. Jonathan Vigliotti is...",
          urlToImage: "https://i.ytimg.com/vi/qRJXNGQrglQ/maxresdefault.jpg",
          publishedAt: "2022-04-10T23:49:10Z",
          content: null),
    ];

    test("should return a valid model when the JSON is formatted right", () {
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('articles')) as Map<String, dynamic>;
      final listLength = jsonMap['articles'].length as int;
      for (var index = 0; index < listLength; index++) {
        final singleArticle = jsonMap['articles'][index];
        final result =
            ArticleModel.fromJson(singleArticle as Map<String, dynamic>);
        expect(result, tArticleList[index]);
      }
    });
  });

  group("to json test", () {


    test("should return a JSON map containing the proper data", () {
    // act
     final result =  tArticleModel.toJson();
     // assert
     final tExpectedJsonMap = {
       "title": "title",
       "description": "description",
       "urlToImage": "urlToImage",
       "publishedAt": "publishedAt",
       "content": "content",
       "author": "author",
     };
      expect(result, tExpectedJsonMap);
    });
  });
}
