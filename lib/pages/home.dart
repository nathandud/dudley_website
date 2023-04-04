import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'base.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final testData = """
Layout for a Flex proceeds in six steps:


""";

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: Expanded(
        child: Center(
          child: Markdown(data: testData),
        ),
      ),
    );
  }
}
