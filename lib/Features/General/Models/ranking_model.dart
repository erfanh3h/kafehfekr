class RankingModel {
  String userId, username;
  int userImage, number;
  DateTime? joinData;

  RankingModel({
    required this.userId,
    required this.username,
    required this.userImage,
    required this.number,
    this.joinData,
  });

  factory RankingModel.fromScoreJson(Map data) {
    return RankingModel(
      userId: data['_id'],
      username: data['username'],
      userImage: data['image'],
      number: data['score'],
      joinData: DateTime.tryParse(data['join_date']),
    );
  }

  factory RankingModel.fromWinJson(Map data) {
    Map userData = data['user_data'];
    int winCount = data['win'];
    return RankingModel(
      userId: userData['_id'],
      username: userData['username'],
      userImage: userData['image'],
      number: winCount,
      joinData: DateTime.tryParse(userData['join_date']),
    );
  }
}
