import 'package:dudley_website/articles/load_article.dart';
import 'package:dudley_website/colors.dart';
import 'package:dudley_website/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ArticleLoader().checkConnection();
  // ArticleLoader.loadArticle(false);

  runApp(DudleyDevApp());
}

class DudleyDevApp extends StatelessWidget {
  DudleyDevApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.macOS) {
      return const MaterialApp();
    }
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        textTheme: GoogleFonts.redHatDisplayTextTheme(),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: DDColors.greenSwatch,
          brightness: Brightness.light,
          primaryColorDark: DDColors.backgroundGreen,
          errorColor: DDColors.vermillionRed,
          accentColor: DDColors.yellowCream,
          backgroundColor: DDColors.backgroundGreen,
        ).copyWith(
          secondary: DDColors.vermillionRed,
        ),
      ),
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
