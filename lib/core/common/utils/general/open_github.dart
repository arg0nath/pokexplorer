import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:url_launcher/url_launcher.dart';

void openGitHub(BuildContext context, {bool isDisclaimer = false}) async {
  final Uri githubUri = Uri.parse(isDisclaimer ? 'https://github.com/arg0nath/pokexplorer/blob/main/DISCLAIMER.md' : 'https://github.com/arg0nath');

  if (await canLaunchUrl(githubUri)) {
    await launchUrl(githubUri, mode: LaunchMode.externalApplication);
  } else {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Could not open GitHub'),
          backgroundColor: context.colorScheme.error,
        ),
      );
  }
}
