class ServerRoutes {
  // static const baseUrl = 'http://192.168.1.6:5000/api/v1';
  // static const baseSocket = 'http://10.0.2.2:5000';
  static const baseSocket = 'http://192.168.1.6:5000';
  static const gameSocket = '$baseSocket/game';
  static const queueSocket = '$baseSocket/queue';
  // static const baseUrl = 'http://185.204.197.77:5000/api/v1';
  // static const enterPhone = '$baseUrl/enter';
  // static const sendCode = '$baseUrl/code';
  // static getData(String id) => '$baseUrl/$id';
  // static const saveDays = '$baseUrl/days';
  // static getDays(String dayNumber) => '$baseUrl/days/$dayNumber';
  // static editDays(String id) => '$baseUrl/days/$id';
}

abstract class SocketChannels {
  static const userCommand = "user_command";
  static const serverCommand = "command";
  static const userReaction = "user_reaction";
  static const serverReaction = "reaction";
}
