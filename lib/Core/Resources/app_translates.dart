import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/get_navigation/src/root/internationalization.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'fa': {
          AppTexts.endGame: 'پایان بازی',
          AppTexts.endRound: 'پایان دور',
          AppTexts.gameDrawed: 'بازی مساوی شد',
          AppTexts.roundDrawed: 'این دور مساوی شد',
          AppTexts.youLoseGame: 'متاسفانه بازی رو باختی!',
          AppTexts.youLoseThisRound: 'این راند رو باختی!',
          AppTexts.youWinGame: 'تبریک برنده ی بازی شدی!',
          AppTexts.youWinThisRound: 'این راند رو بردی!',
          AppTexts.ok: 'بسیار خب',
        },
        'en': {
          AppTexts.endGame: 'Game Finished',
          AppTexts.endRound: 'Round Finished',
          AppTexts.gameDrawed: 'Game Drawed',
          AppTexts.roundDrawed: 'This Round Drawed',
          AppTexts.youLoseGame: 'Unfortunately, you lost the game!',
          AppTexts.youLoseThisRound: 'You lost this round!',
          AppTexts.youWinGame: 'Congratulations, you won the game!',
          AppTexts.youWinThisRound: 'You won this round!',
          AppTexts.ok: 'Ok',
        },
      };
}
