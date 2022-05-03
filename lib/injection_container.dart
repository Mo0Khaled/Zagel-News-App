import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:zagel_news_app/core/network/network_info.dart';
import 'package:zagel_news_app/features/news/data/data_sources/article_locale_data_source.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';
import 'package:zagel_news_app/features/news/domain/use_cases/get_article_by_category_usecase.dart';
import 'package:zagel_news_app/features/news/domain/use_cases/get_article_by_query_use_case.dart';
import 'package:zagel_news_app/features/news/presentation/logic/news_cubit.dart';

import 'features/news/data/data_sources/article_remote_data_source.dart';
import 'features/news/data/repositories/article_repository_impl.dart';

GetIt sl = GetIt.instance; // (sl) service locator

Future<void> setupLocator() async {
  // Register services here
  sl.registerFactory(
    () => NewsCubit(
      getArticleByCategoryUseCase: sl(),
      getArticleByQueryUseCase: sl(),
    ),
  );
  //use cases
  sl.registerLazySingleton(() => GetArticleByCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetArticleByQueryUseCase(sl()));

  // repositories

  sl.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(
      localeDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //! DataSources

  sl.registerLazySingleton<ArticleRemoteDataSource>(
    () => ArticleRemoteDataSourceImpl(
      dio: sl(),
    ),
  );
  sl.registerLazySingleton<ArticleLocaleDataSource>(() => ArticleLocaleDataSourceImpl(hive: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<HiveInterface>(() => Hive);
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<DataConnectionChecker>(
    () => DataConnectionChecker(),
  );
}
