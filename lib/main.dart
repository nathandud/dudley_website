import 'package:dudley_website/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(DudleyDevApp());
}

class DudleyDevApp extends StatelessWidget {
  DudleyDevApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const Color backgroundGreen = Color(0xFF0A5C5A);
    const Color yellowCream = Color(0xFFF4FEC1);
    const Color vermillionRed = Color(0xFFF64740);

    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        textTheme: GoogleFonts.redHatDisplayTextTheme(),
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch: MaterialColor(
                  backgroundGreen.value,
                  <int, Color>{
                    50: backgroundGreen.withOpacity(0.1),
                    100: backgroundGreen.withOpacity(0.2),
                    200: backgroundGreen.withOpacity(0.3),
                    300: backgroundGreen.withOpacity(0.4),
                    400: backgroundGreen.withOpacity(0.5),
                    500: backgroundGreen.withOpacity(0.6),
                    600: backgroundGreen.withOpacity(0.7),
                    700: backgroundGreen.withOpacity(0.8),
                    800: backgroundGreen.withOpacity(0.9),
                    900: backgroundGreen.withOpacity(1.0),
                  },
                ),
                brightness: Brightness.light,
                primaryColorDark: backgroundGreen,
                errorColor: vermillionRed,
                accentColor: yellowCream,
                backgroundColor: backgroundGreen)
            .copyWith(secondary: vermillionRed),
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
