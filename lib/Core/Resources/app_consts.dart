import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';

const String appVersion = "1.1.0";
const MarketTypes marketType = MarketTypes.Myket;

const myketRSA =
    "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCWzTjRpfhobmrMlqNa/gL/3iMUnMjWzpB+CggkB0eqGX8sHrxdb4qPB8e/5wBR1e+gGYttJ5zG0031m+JGwlPf6IJjtfhSTh6m1fdtjdb9wP0btnjqhGVWHwXO2claGmv84GcvvBuzjdpZ6lDPAox05V9ZQ6ut8TkfcMmcApj2bwIDAQAB";
const bazaarRSA =
    "MIHNMA0GCSqGSIb3DQEBAQUAA4G7ADCBtwKBrwCow3MxuHTvNQ9BRJGCma6MHlEQJDU/7+5Z+xmNGffakURNNI9hQhrM5T1ZyFTT+5HCvyel2/ZLyAbGIafuZKgRZL3Jim94pr9JyD3milBjljAvHckViytJMmWPMYDnQ78cO4MOEcpCwe3pVDFvX2aMrPpClWXN/5Z+X9t+vpTXA2jndNRzMO5KCBYOKReLTTiHEcwMYzyXUVtDaBm92FS0WMHB1Di/uTYguIJBbO8CAwEAAQ==";

class GameWaitTimes {
  static const int startGameTime = 5;
  static const int tictactoeRoundTime = 10;
  static const int tictactoeSleepRoundTime = 5;
  static const int rpcRoundTime = 7;
  static const int rpcSleepRoundTime = 3;
  static const int yinshTurnTime = 30;
  static const int yinshRingTime = 20;
  static const int millSelectTime = 15;
  static const int millRemoveTime = 15;
  static const int msweeperGameTime = 600;
  static const int mnumbersTurnTime = 7;
  static const int mnumbersShowResultTime = 2;
  static const int checkersTurnTime = 20;
  static const int chessTurnTime = 20;
  static const int tenSleepRoundTime = 5;
  static const int tenRoundTime = 300;
  static const int othelloTurnTime = 20;
  static const int dotBoxTurnTime = 15;
  static const int yatzyTurnTime = 60;
  static const int fourInRowTurnTime = 15;
  static const int pentagoTurnTime = 25;
  static const int sudokuGameTime = 1200;
  static const int fekrBekrBoardTime = 60;
  static const int fekrBekrTurnTime = 60;
  static const int battleshipBoardTime = 60;
  static const int battleshipTurnTime = 12;
  static const int battleshipWaitTime = 4;
  static const int boxFourTurnTime = 12;
  static const int backGammonTurnTime = 30;
  static const int backOutOfMoveTime = 5;
}

class FontFamilies {
  static const vazir = "Vazir";
  static const dastnevis = "Dastnevis";
  static const playPen = "PlayPen";
  static const hekayat = "Hekayat";
}

abstract class GameCommands {
  static const gameData = "GameData";
  static const gamePlayData = "GamePlayData";
  static const gamePlayTime = "GamePlayTime";
  static const gamePlayNavigate = "GamePlayNavigate";
  static const reconnectData = "ReconnectData";
  static const reaction = "Reaction";
  static const currentTurn = "CurrentTurn";
  static const rollDice = "RollDice";
  static const rollResult = "RollResult";
  static const outOfMove = "OutOfMove";
  static const selectPeace = "SelectPeace";
  static const rotatePeace = "RotatePeace";
  static const selectPeaceResult = "SelectPeaceResult";
  static const swapPeace = "SwapPeace";
  static const removePeace = "RemovePeace";
  static const selectRemovePeace = "SelectRemovePeace";
  static const peaceSelected = "PeaceSelected";
  static const submitRing = "SubmitRing";
  static const ringSubmited = "RingSubmited";
  static const moveRing = "MoveRing";
  static const ringMoved = "RingMoved";
  static const winHappened = "WinHappened";
  static const peaceRotated = "PeaceRotated";
  static const peaceSwaped = "PeaceSwaped";
  static const peaceRemoved = "PeaceRemoved";
  static const newTurnRound = "NewTurnRound";
  static const newRound = "NewRound";
  static const finishTurnRound = "FinishTurnRound";
  static const finishRound = "FinishRound";
  static const startGame = "StartGame";
  static const finishGame = "FinishGame";
  static const selectMine = "SelectMine";
  static const solve = "Solve";
  static const saveBoard = "SaveBoard";
  static const waitTime = "WaitTime";
  static const wrongSolve = "WrongSolve";
  static const selectMineCorrect = "SelectMineCorrect";
  static const selectMineWrong = "SelectMineWrong";
  static const mineSelected = "MineSelected";
  static const playerScore = "PlayerScore";
  static const surrender = "Surrender";
  static const userDisconnected = "UserDisconnected";
  static const userReconnected = "UserReconnected";
  static const finishReconnectTime = "FinishReconnectTime";
  static const gameFinished = "GameFinished";
  static const notPlayedTurns = "NotPlayedTurns";
  static const notEnoughCoin = "NotEnoughCoin";
}

class GeneralGameConsts {
  static const double maxGameWidth = 500;
  static const int maxDisconnectTime = 120;
}

class GameRoundCounts {
  static const int tictactoeRoundCount = 5;
  static const int rpcRoundCount = 3;
  static const int rpcTurnRoundCount = 5;
  static const int tenRoundCount = 3;
}

class StorageKeys {
  static const String userId = "userId";
  static const String token = "token";
  static const String gameId = "gameId";
  static const String gameType = "gameType";
  static const String gameMusic = "gameMusic";
}

List<String> bottomNavigationTexts = [
  AppTexts.profile,
  AppTexts.ranking,
  AppTexts.gameMenu,
  AppTexts.library,
  AppTexts.store,
];

List<IconData> bottomNavigationIcons = [
  Icons.person_4_rounded,
  CupertinoIcons.list_dash,
  CupertinoIcons.game_controller_solid,
  CupertinoIcons.book_solid,
  CupertinoIcons.shopping_cart,
];

List<String> koris = [
  "شکست دیگه عادتت شده!",
  "عجب حرکت هوشمندانه‌ای بود!",
  "برنده فقط منم!",
  "بازی شروع نشده، تمومه!",
  "خیلی خوب بازی کردی!",
  "حریف من نیستی!",
  "بازم بردم!",
  "اون استراتژی عالی بود!",
  "قهرمان برگشته!",
  "این فقط تمرین بود!",
  "خوشم اومد از سبک بازیت!",
  "یه باخت دیگه تو کارنامت!",
  "بهتره تسلیم شی!",
  "آفرین!",
  "سریع‌تر از اینم می‌بازی؟",
  "حیف وقتی که گذاشتی!",
  "حرکتت واقعاً تحسین‌برانگیز بود!",
  "بهتره تمرین کنی!",
  "حالا یاد گرفتی؟",
  "ممنونم!",
  "راحت‌تر از این نبود!",
  "این فقط شروعشه!",
  "اون تاکتیک خیلی جالب بود!",
  "تو حتی نزدیک هم نشدی!",
  "پایانش همین بود؟",
  "این یکی رو عالی مدیریت کردی!",
  "بازم دیر کردی!",
  "این برد مال منه!",
  "ایده خوبی داشتی، بهش ادامه بده!",
  "مثل همیشه برنده!",
  "یک حرکت و تموم!",
  "این حرکت غیرمنتظره بود، عالی!",
  "بازی رو یاد بگیر!",
  "بهترین بودن سخته!",
  "خیلی خوب مسیر بازی رو تغییر دادی!",
  "حریف من نیستی!",
  "دوباره باختی!",
  "این تاکتیکت واقعاً کارساز بود!",
  "تو از اول هم شانسی نداشتی!",
  "بردم، طبق معمول!",
  "پیشرفتت تو این بازی محسوسه!",
  "سلیم شو، هنوز وقت داری!",
  "بازم ساده بردم!",
  "خیلی خوب کنترل کردی اوضاع رو!",
  "این فقط یه گرم کردن بود!",
  "قهرمان برگشت!",
  "اون تصمیم واقعاً درست بود!",
  "دیر رسیدی به بازی!",
  "بازی کردن با تو وقت تلف کردنه!",
  "حرکت نهایی‌ات خیلی قوی بود!",
  "با همین سرعت می‌بازی!",
  "یه کلاس درس دیگه برات بود!",
  "این راندو خیلی حرفه‌ای زدی!",
  "هنوز مونده تا به من برسی!",
  "فقط نگاه کن چطور برنده می‌شم!",
  "خیلی خوب بود!",
  "شروع نکرده باختی!",
  "پایان داستان تو همین‌جاست!",
  "عجب حرکت هوشمندانه‌ای!",
  "به همین سادگی!",
  "این فقط یک نمایش بود!",
  "عالی بازی کردی!",
  "پایان رو از الان می‌دونم!",
  "خسته نشدی از باختن؟",
  "به به!",
  "دوباره شانس داری، امتحان کن!",
  "فکر کنم هنوز نوبتت نشده!",
  "اون تاکتیک معرکه بود!",
  "بازی برای شما تفریحه، برای من زندگیه!",
  "توی لیگ خودت بازی کن!",
  "چقد خوب دفاع کردی!",
  "این بود تمام توانت؟",
  "امروز روز تو نبود!",
  "بازی خفنی کردی!",
  "شاید دفعه بعد!",
  "باید تلاش بیشتری کنی!",
  "ایده فوق‌العاده‌ای بود!",
  "هنوز اول راحته!",
];
