import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/common/models/app_models.dart';
import 'package:pokexplorer/core/common/utilities/app_utils.dart';
import 'package:pokexplorer/core/common/variables/app_variables.dart';
import 'package:pokexplorer/core/common/widgets/about_me_dialog.dart';
import 'package:pokexplorer/core/common/widgets/generic_type_card.dart';
import 'package:pokexplorer/core/localization/app_localizations.dart';
import 'package:pokexplorer/presentation/type_selection/bloc/type_selection_bloc.dart';
import 'package:pokexplorer/router/app_router.dart';

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
          icon: const Icon(Icons.info_outline_rounded),
        ),
        scrolledUnderElevation: 0,
        actions: [
          if (kDebugMode) IconButton(onPressed: () => Navigator.pushNamed(context, RouteNames.welcomeScreen), icon: const Icon(Icons.bug_report_outlined)),
          if (kDebugMode) IconButton(onPressed: () => context.showLoadingDialog(), icon: const Icon(Icons.dialpad_outlined)),
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
          //loading lottie animation
          await context.showLoadingDialog();
        }
      },
      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            //pokeball background
            // const Positioned(left: -20, bottom: -50, child: PokeballBackground()),

            //grid list with types
            MyTypesList(typeSelectionBloc: _typeSelectionBloc),
            //next buttonZ`
            if (_typeSelectionBloc.selectedPokemonType.name.isNotEmpty)
              Positioned(
                bottom: MediaQuery.sizeOf(context).height * 0.02,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () => _typeSelectionBloc.add(const ProceedToTypeDetailsScreenEvent()),
                  child: Text(appLocale.next),
                ),
              ),
          ],
        );
      },
    );
  }
}

class MyTypesList extends StatefulWidget {
  const MyTypesList({super.key, required this.typeSelectionBloc});

  final TypeSelectionBloc typeSelectionBloc;

  @override
  State<MyTypesList> createState() => _MyTypesListState();
}

class _MyTypesListState extends State<MyTypesList> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          width: logicalWidth,
          child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              runAlignment: WrapAlignment.spaceEvenly,
              runSpacing: 10,
              spacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: widget.typeSelectionBloc.availableTypes
                  .map((PokemonType e) => GenericTypeCard(
                        onTap: () => widget.typeSelectionBloc.add(SelectTypeEvent(type: e)),
                        pokemonType: e,
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
