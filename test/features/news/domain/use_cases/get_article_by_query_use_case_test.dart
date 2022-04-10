import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';
import 'package:zagel_news_app/features/news/domain/use_cases/get_article_by_query_use_case.dart';

class MockGetArticleByQueryUseCase extends Mock implements ArticleRepository {}
void main(){
  late GetArticleByQueryUseCase useCase;
  late MockGetArticleByQueryUseCase mockGetArticleByQueryUseCase;

  setUp(()  {
  mockGetArticleByQueryUseCase = MockGetArticleByQueryUseCase();
    useCase = GetArticleByQueryUseCase(mockGetArticleByQueryUseCase);
  });

  const tQuery = "query";
  const tArticle = ArticleEntity(
    title: 'title',
    description: 'description',
    urlToImage: 'urlToImage',
    publishedAt: 'publishedAt',
    content: 'content',
    author: 'author',
  );

  test('should get article by query', () async {
    //arrange
    when(() => mockGetArticleByQueryUseCase.getArticleByQuery(tQuery)).thenAnswer((_) async => const Right([tArticle]));
    //act
    final result = await useCase(const Params(query: tQuery));
    //assert
    expect(result, const Right([tArticle]));
    verify(()=>mockGetArticleByQueryUseCase.getArticleByQuery(tQuery)).called(1);
    verifyNoMoreInteractions(mockGetArticleByQueryUseCase);
  });

}
