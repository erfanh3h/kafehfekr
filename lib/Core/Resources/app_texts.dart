abstract class SocketChannels {
  static const userCommand = "userCommand";
  static const userMessage = "userMessage";
}

abstract class GameCommands {
  static const gameData = "GameData";
  static const requestChallenge = "RequestChallenge";
  static const userRequestedChallenge = "UserRequestedChallenge";
  static const selectChallenger = "SelectChallenger";
  static const acceptChallenge = "AcceptChallenge";
  static const startTalk = "StartTalk";
  static const startChallenge = "StartChallenge";
  static const endTalk = "EndTalk";
  static const stopTalk = "StopTalk";
  static const endChallenge = "EndChallenge";
  static const currentTalker = "CurrentTalker";
  static const currentChallenger = "CurrentChallenger";
  static const reaction = "Reaction";
}

abstract class GameTimes {
  static const talkTime = 10;
}

abstract class GameLogs {
  static const challenge = 'چالش ؟';
  static const waitForChallenge = 'منتظر درخواست چالش بمانید ...';
  static const selectChallenger = 'به کی چالش میدی ؟';
  static const listen = 'گوش کنید';
  static const sendingVoice = 'درحال ارسال صدای شما ...';

}