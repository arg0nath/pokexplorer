import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/res/app_assets.dart';
import 'package:pokexplorer/core/common/utils/general/open_github.dart';

class AboutTile extends StatelessWidget {
  const AboutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      applicationName: 'Pokéxplorer',
      applicationIcon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(height: 25, AppAssets.pokexplorerLogo, fit: BoxFit.scaleDown),
          Image.asset(height: 15, AppAssets.pokemonCustomPhrase, fit: BoxFit.scaleDown),
        ],
      ),
      aboutBoxChildren: [
        GestureDetector(
          onTap: () => openGitHub(context),
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Developed & Designed  by:', textAlign: TextAlign.center, style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: <Widget>[
                    SvgPicture.asset(AppAssets.githubLogoSvg, height: 20, width: 20, colorFilter: ColorFilter.mode(context.colorScheme.onSurface, BlendMode.srcIn)),
                    Text('arg0nath', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            children: <InlineSpan>[
              TextSpan(text: 'Made using Flutter\n'),
              TextSpan(text: 'with ❤️ for the community\n'),
            ],
          ),
        ),
        TextButton(
          onPressed: () => openGitHub(context, isDisclaimer: true),
          child: Text(
            'Disclaimer Info',
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
      icon: Icon(Icons.info_outline_rounded),
    );
  }
}
