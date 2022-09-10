// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

class TelegramApp {
  static const BOT_TOKEN = '507893192546:AAGdS1tePc1rmH6_mo2IQSLR3wogcz5bzr8';
  static const telegramChatId = -78188388424;
  late final teledart;

  TelegramApp();

  init() async {
    final username = (await Telegram(BOT_TOKEN).getMe()).username;
    teledart = TeleDart(BOT_TOKEN, Event(username!));
    teledart.start();
  }

  sendTeleMsg(String message) {
    teledart.sendMessage(telegramChatId, message);
  }
}
