part of 'summaries_cubit.dart';

abstract class ArticleSummariesState {}

class ArticleSummariesLoading extends ArticleSummariesState {}

class ArticleSummariesLoaded extends ArticleSummariesState {
  final List<ArticleSummary> summaries;

  ArticleSummariesLoaded(this.summaries);

  List<Object?> get props => [summaries];
}

class ArticleSummariesError extends ArticleSummariesState {
  final String message;

  ArticleSummariesError(this.message);

  List<Object?> get props => [message];
}
