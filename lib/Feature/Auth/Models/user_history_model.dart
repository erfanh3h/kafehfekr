class UserHistoryModel {
  final int winNormal, loseNormal, drawNormal;

  UserHistoryModel(
      {required this.winNormal,
      required this.loseNormal,
      required this.drawNormal});

  factory UserHistoryModel.fromJson(Map data) {
    return UserHistoryModel(
      winNormal: data['win_normal'],
      loseNormal: data['lose_normal'],
      drawNormal: data['draw_normal'],
    );
  }
  UserHistoryModel copyWith({
    final int? loseNormal,
    final int? winNormal,
    final int? drawNormal,
  }) =>
      UserHistoryModel(
        loseNormal: loseNormal ?? this.loseNormal,
        winNormal: winNormal ?? this.winNormal,
        drawNormal: drawNormal ?? this.drawNormal,
      );
}
