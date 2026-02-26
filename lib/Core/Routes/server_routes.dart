class ServerRoutes {
  // static const baseSocket = 'http://10.0.2.2:5000';
  // static const baseSocket = 'http://5.57.32.37:5000';
  static const baseSocket = 'http://192.168.1.2:5000';
  // static const baseServer = 'http://5.57.32.37:5001';
  static const baseServer = 'http://192.168.1.2:5001';
  static const gameSocket = '$baseSocket/game';
  static const queueSocket = '$baseSocket/queue';
  static const multiQueueSocket = '$baseSocket/multi-queue';
  static const chat = '$baseSocket/chat';
  static const lobbySocket = '$baseSocket/lobby';
  static const enterUser = '$baseServer/enter';
  static const enterCode = '$baseServer/code';
  static const completeUserData = '$baseServer/complete-data';
  static const myData = '$baseServer/my-data';
  static String userData(String id) => '$baseServer/user-data/$id';
  static const configData = '$baseServer/config';
  static const myHistory = '$baseServer/my-history';
  static const changeImage = '$baseServer/update-image';
  static const changeUsername = '$baseServer/update-username';
  static const rankingByWin = '$baseServer/ranking-by-win';
  static const getFreeCoin = '$baseServer/get-free-coin';
  static const rankingByScore = '$baseServer/ranking-by-score';
  static const purchase = '$baseServer/purchase';
  static const bazaarLink = 'https://cafebazaar.ir/app/kafeh.fekr.classic';
  static const myketLink = 'https://myket.ir/app/kafeh.fekr.classic';
  // static getData(String id) => '$baseUrl/$id';
}

abstract class SocketChannels {
  static const userCommand = "user_command";
  static const serverCommand = "command";
  static const userReaction = "user_reaction";
  static const serverReaction = "reaction";
}

abstract class GuideLinks {
  static const mSweeper = "https://www.aparat.com/v/z02m4n3";
  static const yatzy = "https://www.aparat.com/v/cV7aN";
  static const pentago = "https://www.aparat.com/v/a5U3K";
  static const sudoku = "https://www.aparat.com/v/t21n9zb";
  static const chess = "https://www.aparat.com/v/m63uocq";
  static const checkers = "https://www.aparat.com/v/e02c7mp";
  static const othello = "https://www.aparat.com/v/g1739c7";
  static const mill = "https://www.aparat.com/v/o39z663";
  static const yinsh = "https://www.aparat.com/v/o99o411";
  static const backGammon = "https://www.aparat.com/v/k90i80w";
}
