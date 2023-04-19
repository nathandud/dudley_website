import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, debugPrint, defaultTargetPlatform;

import '../models/article_summary.dart';

class ArticleLoader {
  void checkConnection() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();

    await ref.child("test").push().set(true);
  }

  static Future<void> loadArticle(bool isActive) async {
    if (defaultTargetPlatform != TargetPlatform.macOS) {
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles();
    final path = result?.files.single.path;

    if (path == null) {
      return;
    }

    File file = File(path);

    try {
      String fileContent = await file.readAsString();
      List<String> lines = fileContent.trim().split('\n');

      String identifier = lines[0].trim();
      String title = lines[1].trim();
      String subtitle = lines[2].trim();
      List<String> tags = lines[3].trim().split(',');
      String imageURL = lines[4].trim();
      String author = lines[5].trim();

      String? summary =
          RegExp('<(.*?)>', dotAll: true).firstMatch(fileContent)?.group(1);

      String? markdownContent = RegExp(r'Article ---\s*(.*)$', dotAll: true)
          .firstMatch(fileContent)
          ?.group(1);

      //Validate
      if (summary == null) {
        debugPrint("Could not parse summary");
        return;
      }

      if (markdownContent == null) {
        debugPrint("Could not parse markdown content");
        return;
      }

      if (title.isEmpty) {
        debugPrint("Title cannot be empty");
      }

      if (author.isEmpty) {
        author = "Nathan Dudley";
      }

      DatabaseReference topRef = FirebaseDatabase.instance.ref();
      DatabaseReference summaryRef =
          topRef.child('summaries').child(identifier);
      DatabaseReference contentRef;

      bool articleExists = false;

      if (identifier == "ID") {
        summaryRef = topRef.child('summaries').push();
        contentRef = topRef.child('content').push();
      } else {
        final DataSnapshot articleSnapshot = await summaryRef.get();
        articleExists = articleSnapshot.exists;

        final contentID = ArticleSummary.fromJson(
                jsonDecode(jsonEncode(articleSnapshot.value)))
            .contentId;
        contentRef = topRef.child('content').child(contentID);
      }

      await contentRef.set({
        'title': title,
        'subtitle': subtitle,
        'content': markdownContent,
      });

      debugPrint(
          "${articleExists ? 'Edited' : 'Created'} content snapshot with ID ${contentRef.key}");

      Map<String, Object?> summaryObject = {
        'contentId': contentRef.key,
        'title': title,
        'subtitle': subtitle,
        'tags': tags,
        'imageURL': imageURL,
        'author': author,
        'summary': summary,
        'isActive': isActive,
      };

      summaryObject[articleExists ? 'editedDate' : 'createdDate'] =
          DateTime.now().toIso8601String();

      await summaryRef.set(summaryObject);

      debugPrint(
          "${articleExists ? 'Edited' : 'Created'} content snapshot with ID ${summaryRef.key}");

      _replaceFirstLine(file, summaryRef.key);

      /// Add the identifier to the top of the .md file
    } catch (e) {
      // Handle any errors that occur during file reading
      debugPrint('Error loading article: $e');
    }
  }

  static void _replaceFirstLine(File file, String? withString) {
    file.readAsString().then((String contents) {
      List<String?> lines = contents.split('\n');
      lines[0] = withString;
      String newContents = lines.join('\n');
      file.writeAsString(newContents);
    });
  }
}
