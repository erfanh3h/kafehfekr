class ServerRoutes {
  // static const baseSocket = 'http://10.0.2.2:5000';
  // static const baseSocket = 'http://5.57.32.37:5000';
  static const baseSocket = 'http://192.168.1.6:5000';
  // static const baseServer = 'http://5.57.32.37:5001';
  static const baseServer = 'http://192.168.1.6:5001';
  static const gameSocket = '$baseSocket/game';
  static const queueSocket = '$baseSocket/queue';
  static const enterUser = '$baseServer/enter';
  static const enterCode = '$baseServer/code';
  static const completeUserData = '$baseServer/complete-data';
  static const myData = '$baseServer/my-data';
  static const configData = '$baseServer/config';
  static const myHistory = '$baseServer/my-history';
  static const changeImage = '$baseServer/update-image';
  static const rankingByWin = '$baseServer/ranking-by-win';
  static const rankingByScore = '$baseServer/ranking-by-score';
  // static getData(String id) => '$baseUrl/$id';
}

abstract class SocketChannels {
  static const userCommand = "user_command";
  static const serverCommand = "command";
  static const userReaction = "user_reaction";
  static const serverReaction = "reaction";
}
