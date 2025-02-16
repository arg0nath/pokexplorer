import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/common/constants/app_constants.dart';
import 'package:pokexplorer/core/common/models/app_models.dart';
import 'package:pokexplorer/core/common/utilities/app_utils.dart';
import 'package:pokexplorer/core/common/widgets/about_me_dialog.dart';
import 'package:pokexplorer/core/common/widgets/custom_action_button.dart';
import 'package:pokexplorer/core/common/widgets/selected_type_container.dart';
import 'package:pokexplorer/core/theme/colors/app_palette.dart';
import 'package:pokexplorer/localization/app_localizations.dart';
import 'package:pokexplorer/presentation/type_selection/bloc/type_selection_bloc.dart';
import 'package:pokexplorer/router/app_router.dart';

import '../../../core/common/variables/app_variables.dart';

class TypeSelectionScreen extends StatefulWidget {
  const TypeSelectionScreen({super.key});

  @override
  State<TypeSelectionScreen> createState() => _TypeSelectionScreenState();
}

class _TypeSelectionScreenState extends State<TypeSelectionScreen> {
  late final TypeSelectionBloc _typeSelectionBloc = context.read<TypeSelectionBloc>();
  late LocalizationManager appLocale = LocalizationManager.getInstance();

  @override
  void initState() {
    _typeSelectionBloc.add(const LoadTypesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _typeSelectionAppbar(context),
      body: _typeSelectionBody(),
    );
  }

  AppBar _typeSelectionAppbar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () => _typeSelectionBloc.add(const ShowInfoDialogEvent()),
            icon: const Icon(
              Icons.info_outline_rounded,
            )),
        scrolledUnderElevation: 0,
        actions: [
          IconButton(onPressed: () => Navigator.pushNamed(context, RouteNames.welcomeScreen), icon: const Icon(Icons.bug_report_outlined)),
        ],
        title: Text(appLocale.typeSelectionAppBarTitle, style: Theme.of(context).textTheme.titleMedium));
  }

  Widget _typeSelectionBody() {
    return BlocConsumer<TypeSelectionBloc, TypeSelectionState>(
      listener: (context, state) async {
        if (state.typeSelectionStatus == TypeSelectionStatus.readyToProceedToTypeDetailsScreen) {
          //close dialog and navigate to typedetails
          Navigator.popAndPushNamed(context, RouteNames.typeDetailsScreen, arguments: TypeDetailsScreenArguments(typeDetails: _typeSelectionBloc.selectedPokemonTypeDetails));
        } else if (state.typeSelectionStatus == TypeSelectionStatus.errorToProceedToTypeDetailsScreenNoSelection) {
          AppUtils.myToast(context, appLocale.emptyTypeSelectionError); // show select type first toast
        } else if (state.typeSelectionStatus == TypeSelectionStatus.errorToNotifyForNoInternet) {
          AppUtils.myToast(context, appLocale.connectionFailure); // show toast to inform about connection failure
        } else if (state.typeSelectionStatus == TypeSelectionStatus.showInfoDialog) {
          await showDialog<bool>(barrierDismissible: true, context: context, builder: (BuildContext context) => const AboutMeDialog()); //show about me dialog
        } else if (state.typeSelectionStatus == TypeSelectionStatus.proceedingToTypeDetailsScreen) {
          await AppUtils.showLoadingDialog(context); //loading lottie animation
        }
      },
      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            //pokeball background
            const Positioned(left: -20, bottom: -50, child: PokeballBackground()),

            //grid list with types
            MyTypesGrid(typeSelectionBloc: _typeSelectionBloc),
            //next buttonZ`

            Positioned(
                bottom: MediaQuery.sizeOf(context).height * 0.02, child: CustomActionButton(text: appLocale.next, onPressed: () => _typeSelectionBloc.add(const ProceedToTypeDetailsScreenEvent()))),
          ],
        );
      },
    );
  }
}

class MyTypesGrid extends StatefulWidget {
  const MyTypesGrid({super.key, required this.typeSelectionBloc});

  final TypeSelectionBloc typeSelectionBloc;

  @override
  State<MyTypesGrid> createState() => _MyTypesGridState();
}

class _MyTypesGridState extends State<MyTypesGrid> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: logicalHeight,
      // padding: EdgeInsets.only(bottom: app_vars.logicalHeight * 0.1),
      child: GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          gridDelegate: _gridDelegate(),
          itemCount: widget.typeSelectionBloc.availableTypes.length,
          itemBuilder: (context, index) {
            return MyTypeCard(
                onTap: () => widget.typeSelectionBloc.add(SelectTypeEvent(type: widget.typeSelectionBloc.availableTypes[index])), pokemonType: widget.typeSelectionBloc.availableTypes[index]);
          }),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _gridDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 16 / 9,
      mainAxisSpacing: 10.0,
    );
  }
}

class MyTypeCard extends StatefulWidget {
  const MyTypeCard({
    super.key,
    required this.onTap,
    required this.pokemonType,
  });

  final PokemonType pokemonType;

  final VoidCallback onTap;

  @override
  State<MyTypeCard> createState() => _MyTypeCardState();
}

class _MyTypeCardState extends State<MyTypeCard> {
  @override
  Widget build(BuildContext context) {
    final typeColor = widget.pokemonType.getTypeColor();
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          // image type + name
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: widget.pokemonType.isSelected ? typeColor.withAlpha(30) : AppPalette.white,
                  borderRadius: BorderRadius.circular(CIRCULAR_RADIUS),
                  border: Border.all(color: widget.pokemonType.isSelected ? typeColor : Theme.of(context).colorScheme.surface)),
              padding: const EdgeInsets.all(10),
              width: logicalWidth * 0.4,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5,
                  children: [
                    Expanded(flex: 2, child: Image.asset(widget.pokemonType.icon)),
                    Flexible(
                        flex: 1,
                        child: Text(
                          widget.pokemonType.name.toUpperFirst(),
                          style: Theme.of(context).textTheme.labelMedium,
                        )),
                  ],
                ),
              ),
            ),
          ),
          //selected or not - icon
          Positioned(
            bottom: 7,
            right: logicalWidth * 0.06,
            child: (widget.pokemonType.isSelected) ? Icon(Icons.check_circle_outline_rounded, color: typeColor) : const Icon(Icons.circle_outlined, color: Colors.black12),
          ),
        ],
      ),
    ).animate().fade(duration: 300.ms, curve: Curves.easeOutQuad).scale();
  }
}
