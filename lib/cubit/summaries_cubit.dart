import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/article_summary.dart';

part 'summaries_state.dart';

class ArticleSummariesCubit extends Cubit<ArticleSummariesState> {
  ArticleSummariesCubit() : super(ArticleSummariesLoading()) {
    _fetchArticleSummaries();
  }

  final DatabaseReference summariesRef =
      FirebaseDatabase.instance.ref().child('summaries');

  Future<void> _fetchArticleSummaries() async {
    try {
      emit(ArticleSummariesLoading());

      DataSnapshot summariesSnapshot = (await summariesRef.once()).snapshot;

      List<dynamic> allSummaries =
          jsonDecode(jsonEncode(summariesSnapshot.value));

      List<ArticleSummary> summaries =
          allSummaries.map((e) => ArticleSummary.fromJson(e)).toList();

      emit(ArticleSummariesLoaded(summaries));
    } catch (e) {
      emit(ArticleSummariesError(e.toString()));
    }
  }
}
