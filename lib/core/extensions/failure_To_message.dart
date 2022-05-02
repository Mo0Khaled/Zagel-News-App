import 'package:zagel_news_app/core/constant/messages.dart';
import 'package:zagel_news_app/core/exceptions/failure.dart';

extension FailureToMessage on Failure {
  String get toMessage {
    switch (runtimeType) {
      case ServerFailure:
        return Messages.serverFailure;
      case CacheFailure:
        return Messages.cacheFailure;
      default:
        return Messages.unknownFailure;
    }
  }
}
