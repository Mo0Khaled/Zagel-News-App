import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zagel_news_app/core/constant/messages.dart';
import 'package:zagel_news_app/core/exceptions/failure.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';
import 'package:zagel_news_app/features/news/domain/use_cases/get_article_by_category_usecase.dart';
import 'package:zagel_news_app/features/news/domain/use_cases/get_article_by_query_use_case.dart';
import 'package:zagel_news_app/features/news/presentation/logic/news_cubit.dart';
import 'package:dartz/dartz.dart';

class MockGetArticleByCategory extends Mock
    implements GetArticleByCategoryUseCase {}

class MockGetArticleByQuery extends Mock implements GetArticleByQueryUseCase {}

void main() {
  late MockGetArticleByCategory mockGetArticleByCategory;
  late MockGetArticleByQuery mockGetArticleByQuery;
  late NewsCubit newsCubit;
  setUp(() {
    mockGetArticleByCategory = MockGetArticleByCategory();
    mockGetArticleByQuery = MockGetArticleByQuery();
    newsCubit = NewsCubit(
      getArticleByCategoryUseCase: mockGetArticleByCategory,
      getArticleByQueryUseCase: mockGetArticleByQuery,
    );
  });

  group("GetArticleByCategory", () {
    const tCategory = category_type.business;
    const tArticle = ArticleEntity(
      title: 'title',
      description: 'description',
      urlToImage: 'urlToImage',
      publishedAt: 'publishedAt',
      content: 'content',
      author: 'author',
    );
    const tArticleList = [tArticle, tArticle, tArticle];
    test('should emit [loading,success] when the data is fetched successfully',
        () async {
      // arrange
      when(() => mockGetArticleByCategory(
              const GetArticlesCategoryUseCaseParams(category: tCategory)))
          .thenAnswer((_) async => const Right(tArticleList));
      // assert later
      final expected = [
        NewsLoading(),
        NewsSuccess(),
      ];
      expectLater(newsCubit.stream, emitsInOrder(expected));
      // act

      await newsCubit.getArticlesByCategory(tCategory);
    });

    test(
        'should emit [loading,Failure] when the request is unsuccessfully',
        () async {
      // arrange
      when(() => mockGetArticleByCategory(
              const GetArticlesCategoryUseCaseParams(category: tCategory)))
          .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        NewsLoading(),
        const NewsFailure(errorMessage: Messages.serverFailure),
      ];
      expectLater(newsCubit.stream, emitsInOrder(expected));
      // act

      await newsCubit.getArticlesByCategory(tCategory);
    });

    test(
        'should emit [loading,Failure] with the proper message when couldnt get the data from cache',
            () async {
          // arrange
          when(() => mockGetArticleByCategory(
              const GetArticlesCategoryUseCaseParams(category: tCategory),))
              .thenAnswer((_) async => Left(CacheFailure()));
          // assert later
          final expected = [
            NewsLoading(),
            const NewsFailure(errorMessage: Messages.cacheFailure),
          ];
          expectLater(newsCubit.stream, emitsInOrder(expected));
          // act

          await newsCubit.getArticlesByCategory(tCategory);
        });
  });

  group("GetArticleByQuery", () {
    const tQuery = "ronaldo";
    const tArticle = ArticleEntity(
      title: 'title',
      description: 'description',
      urlToImage: 'urlToImage',
      publishedAt: 'publishedAt',
      content: 'content',
      author: 'author',
    );
    const tArticleList = [tArticle, tArticle, tArticle];
    test('should emit [loading,success] when the data is fetched successfully',
            () async {
          // arrange
          when(() => mockGetArticleByQuery(
              const GetArticlesQueryUseCaseParams(query: tQuery)))
              .thenAnswer((_) async => const Right(tArticleList));
          // assert later
          final expected = [
            NewsLoading(),
            NewsSuccess(),
          ];
          expectLater(newsCubit.stream, emitsInOrder(expected));
          // act

          await newsCubit.getArticlesByQuery(tQuery);
        });

    test(
        'should emit [loading,Failure] when the request is unsuccessfully',
            () async {
          // arrange
          when(() => mockGetArticleByQuery(
              const GetArticlesQueryUseCaseParams(query: tQuery)))
              .thenAnswer((_) async => Left(ServerFailure()));
          // assert later
          final expected = [
            NewsLoading(),
            const NewsFailure(errorMessage: Messages.serverFailure),
          ];
          expectLater(newsCubit.stream, emitsInOrder(expected));
          // act

          await newsCubit.getArticlesByQuery(tQuery);
        });

    test(
        'should emit [loading,Failure] with the proper message when couldnt get the data from cache',
            () async {
          // arrange
          when(() => mockGetArticleByQuery(
            const GetArticlesQueryUseCaseParams(query: tQuery),))
              .thenAnswer((_) async => Left(CacheFailure()));
          // assert later
          final expected = [
            NewsLoading(),
            const NewsFailure(errorMessage: Messages.cacheFailure),
          ];
          expectLater(newsCubit.stream, emitsInOrder(expected));
          // act

          await newsCubit.getArticlesByQuery(tQuery);
        });
  });

}
