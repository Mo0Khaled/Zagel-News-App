import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zagel_news_app/core/exceptions/exceptions.dart';
import 'package:zagel_news_app/core/exceptions/failure.dart';
import 'package:zagel_news_app/core/platform/network_info.dart';
import 'package:zagel_news_app/features/news/data/data_sources/article_locale_data_source.dart';
import 'package:zagel_news_app/features/news/data/data_sources/article_remote_data_source.dart';
import 'package:zagel_news_app/features/news/data/models/article_model.dart';
import 'package:zagel_news_app/features/news/data/repositories/article_repository_impl.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';

class MockArticleRemoteDataSource extends Mock implements ArticleRemoteDataSource {}

class MockArticleLocaleDataSource extends Mock implements ArticleLocaleDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}
void main() {
  late ArticleRepositoryImpl repository;
  late MockArticleRemoteDataSource mockArticleRemoteDataSource;
  late MockArticleLocaleDataSource mockArticleLocaleDataSource;
  late MockNetworkInfo mockNetworkInfo;
  setUp(() {
    mockArticleRemoteDataSource = MockArticleRemoteDataSource();
    mockArticleLocaleDataSource = MockArticleLocaleDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ArticleRepositoryImpl(
      remoteDataSource: mockArticleRemoteDataSource,
      localeDataSource: mockArticleLocaleDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
  group('getArticles' ,(){
    const tCategory = category_type.sports;
    const ArticleModel tArticleModel = ArticleModel(
      title: 'title',
      description: 'description',
      urlToImage: 'urlToImage',
      publishedAt: 'publishedAt',
      content: 'content',
      author: 'author',
    );
  const ArticleEntity tArticleEntity = tArticleModel;

  const tArticleModelList = [tArticleModel];

    test(
        'should call  getArticles  method  of  remoteDataSource  when  isConnected  is true',
       ()async{
       // arrange
       when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
       when(()=>mockArticleRemoteDataSource.getArticleByCategory(tCategory)).thenAnswer((_) async =>   tArticleModelList);
       when(()=> mockArticleLocaleDataSource.cacheArticleLocale(tArticleModelList) ).thenAnswer((_) async =>  {});

       // act
           repository.getArticleByCategory(tCategory);
       // assert
        verify(()=>mockNetworkInfo.isConnected);
      }
    );
    group('device is online', (){
      setUp((){
        when(()=> mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when the call to remote data source is successful',()async{
        //arrange
        when(()=>mockArticleRemoteDataSource.getArticleByCategory(tCategory)).thenAnswer((_) async =>   tArticleModelList);
        when(()=> mockArticleLocaleDataSource.cacheArticleLocale(tArticleModelList) ).thenAnswer((_) async =>  {});

        //act
        final result = await repository.getArticleByCategory(tCategory);
        //assert
        verify(()=>mockArticleRemoteDataSource.getArticleByCategory(tCategory)).called(1);
        expect(result, equals( const Right(tArticleModelList)));
      });

      test('should cache the data locally when the call to remote data source is successful',()async{
        //arrange
        when(()=>mockArticleRemoteDataSource.getArticleByCategory(tCategory)).thenAnswer((_) async =>   tArticleModelList);
        when(()=> mockArticleLocaleDataSource.cacheArticleLocale(tArticleModelList) ).thenAnswer((_) async =>  {});
        //act
       await repository.getArticleByCategory(tCategory);

        //assert
        verify(()=>mockArticleRemoteDataSource.getArticleByCategory(tCategory));
        verify(()=>mockArticleLocaleDataSource.cacheArticleLocale(tArticleModelList));

      });

      test('should return server failure when the call to remote data source is unsuccessful',()async{
        //arrange
        when(()=>mockArticleRemoteDataSource.getArticleByCategory(tCategory)).thenThrow(ServerException());
        when(()=> mockArticleLocaleDataSource.cacheArticleLocale(tArticleModelList) ).thenAnswer((_) async =>  {});

        //act
        final result = await repository.getArticleByCategory(tCategory);
        //assert
        verify(()=>mockArticleRemoteDataSource.getArticleByCategory(tCategory)).called(1);
        verifyZeroInteractions(mockArticleLocaleDataSource);  //verify that no interaction with local data source
        expect(result, equals( Left(ServerFailure())));
      });
    });
    group('device is offline', (){
      setUp((){
        when(()=> mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
    });
  } );
}
