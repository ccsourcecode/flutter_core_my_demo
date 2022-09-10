import 'l10n.dart';

/// The translations for Chinese (`zh`).
class L10nZh extends L10n {
  L10nZh([String locale = 'zh']) : super(locale);

  @override
  String get app_title => 'App标题';

  @override
  String get main_title => '主标题';

  @override
  String get message_tip => '点击按钮次数: \$count';
}
