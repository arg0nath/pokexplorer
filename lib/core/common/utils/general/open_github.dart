import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void openGitHubProfile(BuildContext context) async {
  final Uri githubUri = Uri.parse('https://github.com/arg0nath');

  if (await canLaunchUrl(githubUri)) {
    await launchUrl(githubUri, mode: LaunchMode.externalApplication);
  } else {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Could not open GitHub profile'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
  }
}
