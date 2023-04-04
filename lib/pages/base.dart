import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

//https://www.fluttertemplates.dev/widgets/navigation/nav_bar#responsive

class BasePage extends StatelessWidget {
  BasePage({Key? key, required this.body}) : super(key: key);

  final profileUrl =
      "https://media.licdn.com/dms/image/D5603AQEi9CXNFVM-8A/profile-displayphoto-shrink_200_200/0/1679258482101?e=1686182400&v=beta&t=SuV_II6YkpnS1_S1aBgblV-MsXoqurqRe--0ATrtjHg";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
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
                style: GoogleFonts.permanentMarker(fontSize: 36),
              ),
              if (isLargeScreen) Expanded(child: _navBarItems())
            ],
          ),
        ),
      ),
      drawer: isLargeScreen ? null : _drawer(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BioSquare(profileUrl: profileUrl),
          body,
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
                onTap: () {},
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

class BioSquare extends StatelessWidget {
  const BioSquare({
    super.key,
    required this.profileUrl,
  });

  final String profileUrl;

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle =
        Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 16);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: 250,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                profileUrl,
                height: 150,
                width: 150,
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Nathan Dudley is an iOS Engineer and occassional blogger. Swift hobbyist since 2014, professional since 2019. Formerly ',
                    style: textStyle,
                  ),
                  TextSpan(
                      text: 'Chatbooks',
                      style: textStyle?.copyWith(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.https('www.chatbooks.com'));
                        }),
                  TextSpan(text: ', ', style: textStyle),
                  TextSpan(
                      text: 'Alkami',
                      style: textStyle?.copyWith(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.https('www.alkami.com'));
                        }),
                  TextSpan(text: ', and ', style: textStyle),
                  TextSpan(
                      text: 'PepsiCo',
                      style: textStyle?.copyWith(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.https('www.pepsico.com'));
                        }),
                  TextSpan(text: '.', style: textStyle),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(FontAwesomeIcons.github),
                  visualDensity: VisualDensity.compact,
                  onPressed: () =>
                      launchUrl(Uri.https("www.github.com", "nathandud")),
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.twitter, size: 25),
                  onPressed: () =>
                      launchUrl(Uri.https("www.twitter.com", "nathandud")),
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.linkedin, size: 25),
                  onPressed: () => launchUrl(
                      Uri.https("www.linkedin.com", "in/dudleynathan")),
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.stackOverflow, size: 25),
                  onPressed: () => launchUrl(Uri.https(
                      "www.stackoverflow.com", "users/3866299/nathan-dudley")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

final List<String> _menuItems = <String>[
  'About',
  'Contact',
  'Settings',
  'Sign Out',
];

enum Menu { itemOne, itemTwo, itemThree }

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(
        icon: const Icon(Icons.person),
        offset: const Offset(0, 40),
        onSelected: (Menu item) {},
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem<Menu>(
                value: Menu.itemOne,
                child: Text('Account'),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.itemTwo,
                child: Text('Settings'),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.itemThree,
                child: Text('Sign Out'),
              ),
            ]);
  }
}
