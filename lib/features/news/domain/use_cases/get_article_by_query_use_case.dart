import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:zagel_news_app/core/exceptions/failure.dart';
import 'package:zagel_news_app/core/usecases/use_case.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';

class GetArticleByQueryUseCase extends UseCase<List<ArticleEntity>,Params>{
  final ArticleRepository repository;

  GetArticleByQueryUseCase(this.repository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(Params params) async{
    return  repository.getArticleByQuery(params.query);
  }


}

class Params extends Equatable{
  final String query;


 const Params({required this.query});

  @override
  List<Object> get props => [query];
}
