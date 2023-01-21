import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zagel_news_app/core/extensions/failure_To_message.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';
import 'package:zagel_news_app/features/news/domain/use_cases/get_article_by_category_usecase.dart';
import 'package:zagel_news_app/injection_container.dart';

class ArticlesByCategory extends StateNotifier<AsyncValue<List<ArticleEntity>>> {
  final GetArticleByCategoryUseCase getArticleByCategoryUseCase;

  ArticlesByCategory({
    required this.getArticleByCategoryUseCase,
  }) : super(const AsyncValue.data([])){
    // getArticlesByCategory(category_type.sports);
  }

  Future<void> getArticlesByCategory(category_type tCategory) async {
    state = const AsyncValue.loading();
    final failureOrData = await getArticleByCategoryUseCase(
        GetArticlesCategoryUseCaseParams(category: tCategory));
    failureOrData.fold(
      (failure) => AsyncValue.error(failure.toMessage,StackTrace.current),
      (data) {
        state = AsyncValue.data(data);
      },
    );
  }
}

final articlesByCategoryProvider =
    StateNotifierProvider<ArticlesByCategory, AsyncValue<List<ArticleEntity>>>(
        (ref) => sl<ArticlesByCategory>());
