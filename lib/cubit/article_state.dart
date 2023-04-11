part of 'article_cubit.dart';

abstract class ArticleState {}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final ArticleSummary article;

  ArticleLoaded(this.article);

  List<Object?> get props => [article];
}

class ArticleError extends ArticleState {
  final String message;

  ArticleError(this.message);

  List<Object?> get props => [message];
}
