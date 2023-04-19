import 'package:dudley_website/cubit/summaries_cubit.dart';
import 'package:dudley_website/models/article_summary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'base.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticleSummariesCubit(),
      child: BlocBuilder<ArticleSummariesCubit, ArticleSummariesState>(
        builder: (context, state) {
          if (state is ArticleSummariesLoading) {
            return BasePage(
              body: const MarkdownBody(data: "Hello"),
            );
          } else if (state is ArticleSummariesLoaded) {
            List<ArticleSummary> summaries = state.summaries;
            return BasePage(
              body: const Text("Done loading"),
            );
          } else if (state is ArticleSummariesError) {
            String text = kDebugMode ? state.message : "There was an error";
            return BasePage(
              body: Text(text),
            );
          } else {
            return BasePage(
              body: const Text("What else?"),
            );
          }
        },
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
