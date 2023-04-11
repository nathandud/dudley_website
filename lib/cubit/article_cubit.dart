import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/article_summary.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit() : super(ArticleInitial());

  final DatabaseReference articleRef =
      FirebaseDatabase.instance.ref().child('articles');

  Future<void> fetchArticle(String articleId) async {
    try {
      emit(ArticleLoading());

      DataSnapshot articleSnapshot =
          (await articleRef.child(articleId).once()).snapshot;

      ArticleSummary article = ArticleSummary.fromJson(
          jsonDecode(jsonEncode(articleSnapshot.value)));

      emit(ArticleLoaded(article));
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }
}
