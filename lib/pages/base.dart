import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/bio_square.dart';

//https://www.fluttertemplates.dev/widgets/navigation/nav_bar#responsive

class BasePage extends StatelessWidget {
  BasePage({Key? key, required this.body}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;
    final bool isMobileScreen = width < 500;
    final bool showDoubleColumn = width > 1000;
    final double titleFontSize = isMobileScreen ? 24 : 36;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        toolbarHeight: 80,
        leading: isLargeScreen
            ? null
            : IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Dudley Dev Diaries",
                style: GoogleFonts.permanentMarker(fontSize: titleFontSize),
              ),
              if (isLargeScreen) Expanded(child: _navBarItems())
            ],
          ),
        ),
      ),
      drawer: isLargeScreen ? null : _drawer(),
      body: showDoubleColumn
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BioSquare(screenWidth: width),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: body,
                    ),
                    // child: Markdown(data: testData),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        body,
                        BioSquare(screenWidth: width),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _drawer() => Drawer(
        child: ListView(
          children: _menuItems
              .map((item) => ListTile(
                    onTap: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                    title: Text(item),
                  ))
              .toList(),
        ),
      );

  Widget _navBarItems() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _menuItems
            .map(
              (item) => InkWell(
                onTap: () {}, //TODO: Route here
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 16),
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
            .toList(),
      );
}

final List<String> _menuItems = <String>[
  'About',
  'Blog',
  'Career',
  'Contact',
];
