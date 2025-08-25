import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokexplorer/core/common/widgets/custom_network_image.dart';
import 'package:pokexplorer/features/settings/domain/usecases/get_copyright_option.dart';
import 'package:pokexplorer/features/settings/domain/usecases/get_terms_option.dart';
import 'package:pokexplorer/features/settings/domain/usecases/set_copyright_option.dart';
import 'package:pokexplorer/features/settings/domain/usecases/set_terms_option.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required GetCopyrightOption getCopyrightOption,
    required SetCopyrightOption setCopyrightOption,
    required GetTermsOption getTermsOption,
    required SetTermsOption setTermsOption,
  })  : _getCopyrightOption = getCopyrightOption,
        _setCopyrightOption = setCopyrightOption,
        _getTermsOption = getTermsOption,
        _setTermsOption = setTermsOption,
        super(SettingsInitial()) {
    on<LoadSettingsEvent>((LoadSettingsEvent event, Emitter<SettingsState> emit) async {
      final bool showCopyrightContent = await _getCopyrightOption();
      final bool acceptedTerms = await _getTermsOption();

      // Update the cache in CustomNetworkImage
      CustomNetworkImage.updateCopyrightVisibility(showCopyrightContent);

      emit(SettingsLoaded(
        showCopyrightedContent: showCopyrightContent,
        termsAccepted: acceptedTerms,
      ));
    });

    on<AcceptTermsEvent>((AcceptTermsEvent event, Emitter<SettingsState> emit) async {
      if (state is SettingsLoaded) {
        await _setTermsOption(event.accepted);
        emit((state as SettingsLoaded).copyWith(termsAccepted: event.accepted));
      }
    });

    on<ToggleCopyrightedContentEvent>((ToggleCopyrightedContentEvent event, Emitter<SettingsState> emit) async {
      if (state is SettingsLoaded) {
        await _setCopyrightOption(event.show);

        // Update the cache in CustomNetworkImage
        CustomNetworkImage.updateCopyrightVisibility(event.show);

        emit((state as SettingsLoaded).copyWith(showCopyrightedContent: event.show));
      }
    });
  }

  final GetCopyrightOption _getCopyrightOption;
  final SetCopyrightOption _setCopyrightOption;
  final GetTermsOption _getTermsOption;
  final SetTermsOption _setTermsOption;
}
