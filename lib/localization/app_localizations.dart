import 'package:flutter/material.dart';

class LocalizationManager {
  static LocalizationManager? _instance;

  // Current locale (set this at the start of the app)
  Locale _locale = Locale('en', 'US');

  // Singleton constructor
  LocalizationManager._();

  static LocalizationManager getInstance() {
    _instance ??= LocalizationManager._();
    return _instance!;
  }

  // Set the locale
  void setLocale(Locale locale) {
    _locale = locale;
  }

  String get welcomeTitle => _localizedStrings[_locale.languageCode]?['welcome_title'] ?? 'Welcome, explorer! A new Poké-search journey is about to begin... Hooray!';
  String get welcomeMessage1 => _localizedStrings[_locale.languageCode]?['welcome_message_1'] ?? 'Pick a type to explore';
  String get welcomeMessage2 => _localizedStrings[_locale.languageCode]?['welcome_message_2'] ?? 'Search through Pokémon';
  String get welcomeMessage3 => _localizedStrings[_locale.languageCode]?['welcome_message_3'] ?? 'View stats of any Pokémon';
  String get welcomeButtonText => _localizedStrings[_locale.languageCode]?['welcome_button_text'] ?? "Let's start!";
  String get next => _localizedStrings[_locale.languageCode]?['next'] ?? 'Next';
  String get typeSelectionAppBarTitle => _localizedStrings[_locale.languageCode]?['type_selection_appbar_title'] ?? 'Pick a Pokémon type';
  String get emptyTypeSelectionError => _localizedStrings[_locale.languageCode]?['empty_type_selection_error'] ?? "Hey! Don't forget to pick a category";
  String get weight => _localizedStrings[_locale.languageCode]?['weight'] ?? 'Weight';
  String get height => _localizedStrings[_locale.languageCode]?['height'] ?? 'Height';
  String get noPokemonFound => _localizedStrings[_locale.languageCode]?['no_pokemon_found'] ?? 'No Pokémon found.';
  String get failedToFetchData => _localizedStrings[_locale.languageCode]?['failed_to_fetch_data'] ?? 'Failed to fetch data.';
  String get connectionFailure => _localizedStrings[_locale.languageCode]?['connection_failure'] ?? 'Please check your internet connection';
  String get contactMe => _localizedStrings[_locale.languageCode]?['contact_me'] ?? 'Contact';
  String get loadingDialogMessage => _localizedStrings[_locale.languageCode]?['loading_dialog_message'] ?? 'Loading Pokémon';
  String get generalErrorMessage => _localizedStrings[_locale.languageCode]?['general_error_message'] ?? 'Oops! Something went wrong';
  String get searchBarTitle => _localizedStrings[_locale.languageCode]?['search_bar_title'] ?? 'Search for a Pokémon';

  // String get greeting => _localizedStrings[_locale.languageCode]?['greeting'] ?? 'Welcome';
}

final Map<String, Map<String, String>> _localizedStrings = {
  'en': {
    'welcome_title': 'Welcome, explorer! A new Poké-search journey is about to begin... Hooray!',
    'welcome_message_1': 'Pick a type to explore',
    'welcome_message_2': 'Search through Pokémon',
    'welcome_message_3': 'View stats of any Pokémon',
    'welcome_button_text': "Let's start!",
    'empty_type_selection_error': "Hey! Don't forget to pick a category",
    'next': 'Next',
    'loading_dialog_message': 'Loading Pokémon',
    'type_selection_appbar_title': 'Pick a Pokémon type',
    'weight': 'Weight',
    'height': 'Height',
    'search_bar_title': 'Search for a Pokémon',
    'no_pokemon_found': 'No Pokémon found.',
    'failed_to_fetch_data': 'Failed to fetch data.',
    'connection_failure': 'Please check your internet connection and try again',
    'contact_me': 'Contact',
    'general_error_message': 'Oops! Something went wrong',
  },
  'el': {
    'contact_me': 'Επικοινωνία',
    'failed_to_fetch_data': 'Αποτυχία λήψης δεδομένων.',
    'welcome_title': 'Καλώς ήρθατε, εξερευνητή! Ένα νέο ταξίδι Poké-αναζήτησης ξεκινά... Ωραία!',
    'welcome_message_1': 'Επιλέξτε έναν τύπο για εξερεύνηση',
    'welcome_message_2': 'Αναζητήστε μέσα από Pokémon',
    'welcome_message_3': 'Δείτε τα στατιστικά κάθε Pokémon',
    'welcome_button_text': "Πάμε!",
    'connection_failure': 'Παρακαλώ ελέγξτε τη σύνδεση στο διαδίκτυο',
    'empty_type_selection_error': 'Έι! Μην ξεχάσετε να επιλέξετε μια κατηγορία',
    'next': 'Επόμενο',
    'loading_dialog_message': 'Φορτώνονται Pokémon',
    'type_selection_appbar_title': 'Επιλέξτε έναν τύπο Pokémon',
    'weight': 'Βάρος',
    'height': 'Ύψος',
    'search_bar_title': 'Ψάξε για κάποιο Pokémon',
    'no_pokemon_found': 'Δεν βρέθηκαν Pokémon.',
    'general_error_message': 'Ουπς! Κάτι πήγε στραβά',
  },
};

// LocalizationManager.getInstance().hello; use

// LocalizationManager.getInstance().setLocale(Locale('el', 'GR')); // Switch to greek