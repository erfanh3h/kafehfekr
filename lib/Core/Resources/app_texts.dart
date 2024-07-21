abstract class SocketChannels {
  static const userCommand = "userCommand";
}

abstract class GameCommands {
  static const gameData = "GameData";
  static const reaction = "Reaction";
  static const currentTurn = "CurrentTurn";
  static const selectPeace = "SelectPeace";
  static const peaceSelected = "PeaceSelected";
  static const newRound = "NewRound";
  static const finishRound = "FinishRound";
  static const finishGame = "FinishGame";
}

abstract class GameTimes {
  static const tictactoeRoundTime = 10;
}

abstract class GameLogs {
  static const challenge = 'چالش ؟';
}