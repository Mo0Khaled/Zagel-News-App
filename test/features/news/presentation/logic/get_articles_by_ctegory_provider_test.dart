import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';
import 'package:zagel_news_app/features/news/domain/use_cases/get_article_by_category_usecase.dart';
import 'package:zagel_news_app/features/news/presentation/logic/get_articles_by_ctegory_provider.dart';

class MockGetArticlesByCategory extends Mock
    implements GetArticleByCategoryUseCase {}

class Listener extends Mock {
  void call(AsyncValue<List<ArticleEntity>>? previous,
      AsyncValue<List<ArticleEntity>> value);
}

void main() {
  late MockGetArticlesByCategory mockGetArticlesByCategory;
  late ArticlesByCategory articlesByCategoryState;
  setUp(() {
    mockGetArticlesByCategory = MockGetArticlesByCategory();
    articlesByCategoryState = ArticlesByCategory(
        getArticleByCategoryUseCase: mockGetArticlesByCategory);
  });

  test("should got list of articles when success ", () async {
    const articles = [
      ArticleEntity(
          author: "author",
          title: "title",
          description: "description",
          urlToImage: "urlToImage",
          publishedAt: "publishedAt",
          content: "content")
    ];
    final container = ProviderContainer(overrides: [
      articlesByCategoryProvider.overrideWith((ref) => articlesByCategoryState),
    ]);
    addTearDown(container.dispose);
    final listener = Listener();
    container.listen<AsyncValue<List<ArticleEntity>>>(
      articlesByCategoryProvider,
      listener,
      fireImmediately: true,
    );
    when(
      () => mockGetArticlesByCategory(
        const GetArticlesCategoryUseCaseParams(
          category: category_type.sports,
        ),
      ),
    ).thenAnswer(
      (invocation) async => const Right(articles),
    );
    // if loading
    container.read(articlesByCategoryProvider.notifier).getArticlesByCategory(category_type.sports);
    expect(container.read(articlesByCategoryProvider), const AsyncValue<List<ArticleEntity>>.loading());
    // if got the data
    await container.read(articlesByCategoryProvider.notifier).getArticlesByCategory(category_type.sports);
    expect(container.read(articlesByCategoryProvider), const AsyncValue<List<ArticleEntity>>.data(articles));

    // verify(() => listener(null, const AsyncValue.loading())).called(1);
  });
}
