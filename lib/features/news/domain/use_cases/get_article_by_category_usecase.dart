import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:zagel_news_app/core/exceptions/failure.dart';
import 'package:zagel_news_app/core/usecases/use_case.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';

class GetArticleByCategoryUseCase extends UseCase<List<ArticleEntity>, Params> {
  final ArticleRepository repository;

  GetArticleByCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(Params params) async{
    return  repository.getArticleByCategory(params.category);
  }


}
class Params extends Equatable {
  final category_type category;

  const Params({required this.category});

  @override
  List<Object?> get props => [category];
}
