import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';
import 'package:zagel_news_app/features/news/domain/use_cases/get_article_by_category_usecase.dart';

class MockArticleRepository extends Mock implements ArticleRepository {}

void main() {
  late GetArticleByCategoryUseCase useCase;
  late MockArticleRepository mockArticleRepository;
  setUp(() {
    mockArticleRepository = MockArticleRepository();
    useCase = GetArticleByCategoryUseCase(mockArticleRepository);
  });
  setUpAll((){
    registerFallbackValue(category_type.sports);

  });
  const tCategory = category_type.sports;
  const tArticle = ArticleEntity(
    title: 'title',
    description: 'description',
    urlToImage: 'urlToImage',
    publishedAt: 'publishedAt',
    content: 'content',
    author: 'author',
  );

  test("should get article from the repository", () async {
    when(() => mockArticleRepository.getArticleByCategory(any()))
        .thenAnswer((_) async => const Right([tArticle]));

    final result = await useCase(const Params(category: tCategory));
    expect(result, const Right([tArticle]));
    verify(() => mockArticleRepository.getArticleByCategory(tCategory)).called(1);
    verifyNoMoreInteractions(mockArticleRepository);
  });
}
