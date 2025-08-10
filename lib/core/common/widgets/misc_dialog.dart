import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pokexplorer/config/theme/domain/entity/theme_entity.dart';
import 'package:pokexplorer/config/theme/presentation/bloc/theme_bloc.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/res/app_assets.dart';
import 'package:pokexplorer/core/common/utils/general/send_email.dart' as AppUtils;
import 'package:pokexplorer/features/type_selection/presentation/bloc/type_selection_bloc.dart';

class MiscDialog extends StatelessWidget {
  const MiscDialog({super.key});

  @override
  Dialog build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConst.circularRadius)),
      elevation: 0.0,
      child: Container(
        width: context.width * 0.7,
        padding: const EdgeInsets.all(25),
        child: Column(mainAxisSize: MainAxisSize.min, spacing: context.height * 0.03, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Flexible(
            flex: 8,
            child: Image.asset(height: 80, AppAssets.pokexplorerLogoPng, fit: BoxFit.scaleDown),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Iconsax.sun_1),
              BlocBuilder<TypeSelectionBloc, TypeSelectionState>(
                builder: (BuildContext context, TypeSelectionState state) {
                  return Switch(
                    value: context.read<ThemeBloc>().state.themeEntity?.themeType == ThemeType.dark,
                    onChanged: (bool value) => context.read<ThemeBloc>().add(ToggleThemeEvent(
                          ThemeEntity(themeType: value ? ThemeType.dark : ThemeType.light),
                        )),
                    // onChanged: (bool value) => <void>{context.read<ThemeBloc>().add(const ToggleThemeEvent())},
                  );
                },
              ),
              const Icon(Iconsax.moon),
            ],
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: theme.textTheme.titleMedium,
              text: 'Made using Flutter by:\n',
              children: <InlineSpan>[
                TextSpan(text: 'arg0nath', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: () async => AppUtils.sendContactEmail(),
            label: Text('Contact me'),
            icon: const Icon(Iconsax.user),
          ),
        ]),
      ),
    );
  }
}
