import 'l10n.dart';

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'app_title';

  @override
  String get main_title => 'My Main Title';

  @override
  String get message_tip => 'You have pushed the button many times: \$count';
}
