import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zagel_news_app/core/extensions/failure_To_message.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';
import 'package:zagel_news_app/features/news/domain/use_cases/get_article_by_category_usecase.dart';
import 'package:zagel_news_app/features/news/domain/use_cases/get_article_by_query_use_case.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final GetArticleByCategoryUseCase getArticleByCategoryUseCase;
  final GetArticleByQueryUseCase getArticleByQueryUseCase;

  NewsCubit({
    required this.getArticleByCategoryUseCase,
    required this.getArticleByQueryUseCase,
  }) : super(NewsInitial());

  Future<void> getArticlesByCategory(category_type tCategory) async {
    emit(NewsLoading());
    final failureOrData = await getArticleByCategoryUseCase(
        GetArticlesCategoryUseCaseParams(category: tCategory));
    failureOrData.fold(
      (failure) => emit(
        NewsFailure(
          errorMessage: failure.toMessage,
        ),
      ),
      (data) => emit(NewsSuccess()),
    );
  }

  Future<void> getArticlesByQuery(String tQuery) async {
    emit(NewsLoading());
    final failureOrData = await getArticleByQueryUseCase(
        GetArticlesQueryUseCaseParams(query: tQuery));
    failureOrData.fold(
          (failure) => emit(
        NewsFailure(
          errorMessage: failure.toMessage,
        ),
      ),
          (data) => emit(NewsSuccess()),
    );
  }
}
