import 'dart:math';

import 'package:dudley_website/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BioSquare extends StatelessWidget {
  const BioSquare({
    super.key,
    this.screenWidth = 800,
  });

  final double screenWidth;

  final profileUrl =
      "https://pbs.twimg.com/profile_images/1155688301120110598/tOoHcXfL_400x400.jpg";

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle =
        Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 16);

    final bool singleColumn = screenWidth < 1000;
    final bool isMobile = screenWidth <= 500;
    final double width = singleColumn ? screenWidth : 250;

    final double hPad = max(screenWidth / 16, 20);
    final double descriptionWidth = min(screenWidth - hPad - 250, 400);

    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, singleColumn ? 20 : 100, hPad, 20),
      child: Container(
        constraints: BoxConstraints(maxWidth: width),
        child: singleColumn
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: isMobile
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: [
                      ProfileCircle(profileUrl: profileUrl),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                minWidth: 150,
                                maxWidth: isMobile ? 150 : descriptionWidth),
                            child: Column(
                              children: [
                                BioDescriptionText(textStyle: textStyle),
                                const SizedBox(height: 16),
                                if (!isMobile)
                                  const SocialsButtonRow(
                                    alignment: MainAxisAlignment.start,
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (isMobile)
                    const SocialsButtonRow(alignment: MainAxisAlignment.center)
                ],
              )
            : Column(
                children: [
                  ProfileCircle(profileUrl: profileUrl),
                  const SizedBox(height: 16),
                  BioDescriptionText(textStyle: textStyle),
                  const SizedBox(height: 16),
                  const SocialsButtonRow(
                      alignment: MainAxisAlignment.spaceEvenly)
                ],
              ),
      ),
    );
  }
}

class SocialsButtonRow extends StatelessWidget {
  const SocialsButtonRow({
    super.key,
    required this.alignment,
  });

  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        IconButton(
          icon: const Icon(FontAwesomeIcons.github),
          hoverColor: DDColors.githubPurple.withOpacity(0.25),
          splashRadius: 24,
          onPressed: () => launchUrl(Uri.https("www.github.com", "nathandud")),
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.twitter),
          hoverColor: DDColors.twitterBlue.withOpacity(0.25),
          splashRadius: 24,
          onPressed: () => launchUrl(Uri.https("www.twitter.com", "nathandud")),
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.linkedin),
          hoverColor: DDColors.linkedInBlue.withOpacity(0.25),
          selectedIcon:
              const Icon(FontAwesomeIcons.linkedin, color: Colors.blue),
          splashRadius: 24,
          onPressed: () =>
              launchUrl(Uri.https("www.linkedin.com", "in/dudleynathan")),
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.stackOverflow, size: 25),
          hoverColor: DDColors.stackOverflowOrange.withOpacity(0.25),
          splashRadius: 24,
          onPressed: () => launchUrl(Uri.https(
              "www.stackoverflow.com", "users/3866299/nathan-dudley")),
        ),
      ],
    );
  }
}

class BioDescriptionText extends StatelessWidget {
  const BioDescriptionText({
    super.key,
    required this.textStyle,
  });

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
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
    );
  }
}

class ProfileCircle extends StatelessWidget {
  const ProfileCircle({
    super.key,
    required this.profileUrl,
  });

  final String profileUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.network(
        profileUrl,
        height: 150,
        width: 150,
      ),
    );
  }
}
