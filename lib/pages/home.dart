import 'package:dudley_website/cubit/summaries_cubit.dart';
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
            return BasePage(
              body: const Text("Done loading"),
            );
          } else {
            return BasePage(
              body: const Text("There was an error"),
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
