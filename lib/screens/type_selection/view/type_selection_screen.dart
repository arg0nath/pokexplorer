import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/router/app_router.dart' as app_router;

import 'package:pokexplorer/screens/type_selection/bloc/type_selection_bloc.dart';
import 'package:pokexplorer/src/utilities/app_utils.dart' as app_utils;
import 'package:pokexplorer/src/variables/app_constants.dart' as app_const;
import 'package:pokexplorer/src/widgets/app_widgets.dart' as app_widgets;
import '../../../src/variables/app_variables.dart' as app_vars;

class TypeSelectionScreen extends StatefulWidget {
  const TypeSelectionScreen({super.key});

  @override
  State<TypeSelectionScreen> createState() => _TypeSelectionScreenState();
}

class _TypeSelectionScreenState extends State<TypeSelectionScreen> {
  late final TypeSelectionBloc _typeSelectionBloc = context.read<TypeSelectionBloc>();

  @override
  void initState() {
    _typeSelectionBloc.add(const LoadTypesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          leading: const SizedBox.shrink(),
          actions: [
            IconButton(
                onPressed: () => _typeSelectionBloc.add(const ShowInfoDialogEvent()),
                icon: const Icon(
                  Icons.info_outline_rounded,
                  color: app_const.SECONDARY_TEXT_COLOR,
                ))
          ],
          title: const app_widgets.MyText('Pick a Pokémon type', style: TextStyle(fontSize: 20, color: app_const.PRIMARY_TEXT_COLOR))),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(backgroundColor: app_const.BRIGHT_RED, side: const BorderSide(width: 1, color: app_const.LIGHT_RED)),
                onPressed: () => _typeSelectionBloc.add(const ProceedToTypeDetailsScreenEvent()),
                child: const app_widgets.MyText('Next', style: TextStyle(color: Colors.white, fontSize: 19)))
          ],
        ),
      ),
      extendBody: true,
      backgroundColor: Colors.white,
      body: BlocConsumer<TypeSelectionBloc, TypeSelectionState>(
        listener: (context, state) async {
          if (state.typeSelectionStatus == TypeSelectionStatus.readyToProceedToTypeDetailsScreen) {
            Navigator.pushNamed(context, app_const.TYPE_DETAILS_SCREEN_PAGE_ROUTE_NAME,
                arguments: app_router.TypeDetailsScreenArguments(typeName: _typeSelectionBloc.selectedPokemonType.name.toLowerCase()));
          } else if (state.typeSelectionStatus == TypeSelectionStatus.readyToProceedToTypeDetailsScreenNoSelection) {
            app_utils.myToast(context, "Hey! Don't forget to pick a category");
          } else if (state.typeSelectionStatus == TypeSelectionStatus.readyToProceedToTypeDetailsScreenGenericFail) {
            app_utils.myToast(context, app_const.GENERIC_ERROR_TOAST_MESSAGE);
          } else if (state.typeSelectionStatus == TypeSelectionStatus.showInfoDialog) {
            await showDialog<bool>(barrierDismissible: true, context: context, builder: (BuildContext context) => const app_widgets.AboutMeDialog());
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              const Positioned(left: -20, bottom: -50, child: app_widgets.PokeballBackground()),
              Container(
                height: app_vars.logicalHeight,
                padding: EdgeInsets.only(bottom: app_vars.logicalHeight * 0.1),
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 16 / 9,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: _typeSelectionBloc.availableTypes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _typeSelectionBloc.add(SelectTypeEvent(type: _typeSelectionBloc.availableTypes[index])),
                      child: Stack(
                        children: [
                          Positioned(
                              bottom: 7,
                              right: app_vars.logicalWidth * 0.06,
                              child: (_typeSelectionBloc.availableTypes[index].isSelected)
                                  ? const Icon(Icons.check_circle_outline_rounded, color: app_const.BRIGHT_RED)
                                  : const Icon(Icons.circle_outlined, color: Color(0xFFEEEEEE))),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(color: _typeSelectionBloc.availableTypes[index].isSelected ? app_const.BRIGHT_RED : const Color(0xFFEEEEEE))),
                              padding: const EdgeInsets.all(10),
                              width: app_vars.logicalWidth * 0.4,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(flex: 2, child: Image.asset(_typeSelectionBloc.availableTypes[index].icon)),
                                    const SizedBox(height: 5),
                                    Flexible(flex: 1, child: app_widgets.MyText(_typeSelectionBloc.availableTypes[index].name)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fade(duration: 300.ms, curve: Curves.easeOutQuad).scale();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
