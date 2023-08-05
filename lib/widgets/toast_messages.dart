import 'package:bot_toast/bot_toast.dart';


void normalToast(message) {
  BotToast.showText(
      text: message,
      duration: const Duration(seconds: 4));
}