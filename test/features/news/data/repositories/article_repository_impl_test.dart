import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zagel_news_app/core/platform/network_info.dart';
import 'package:zagel_news_app/features/news/data/data_sources/article_locale_data_source.dart';
import 'package:zagel_news_app/features/news/data/data_sources/article_remote_data_source.dart';
import 'package:zagel_news_app/features/news/data/repositories/article_repository_impl.dart';

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
}
