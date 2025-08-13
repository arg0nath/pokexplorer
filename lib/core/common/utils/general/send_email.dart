import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:url_launcher/url_launcher.dart';

void sendContactEmail(BuildContext ctx) async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'cv here',
    query: encodeQueryParameters(<String, String>{
      'subject': 'About pokéxplorer',
    }),
  );

  if (await canLaunchUrl(emailLaunchUri)) {
    await launchUrl(emailLaunchUri);
  } else {
    ctx.pop();
    ScaffoldMessenger.of(ctx)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Could not launch email app'),
          backgroundColor: ctx.colorScheme.error,
        ),
      );
  }
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
}
