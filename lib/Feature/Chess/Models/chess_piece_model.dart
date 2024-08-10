class ChessPieceModel {
  ChessPieceModel({
    this.gamerId = 0,
    this.isMultiMove = true,
    this.isFirstMove = true,
    this.image = "",
  });

  int gamerId;
  bool isMultiMove;
  bool isFirstMove;
  String image;

  List<(int, int)> getMovesList() {
    return [];
  }

  List<(int, int)> getHitsList() {
    return getMovesList();
  }

  ChessPieceModel copyWith({
    final int? gamerId,
    final bool? isFirstMove,
  }) =>
      ChessPieceModel(
        gamerId: gamerId??this.gamerId,
        isMultiMove: isMultiMove,
        isFirstMove: isFirstMove ?? this.isFirstMove,
        image: image,
      );
  // ChessPieceModel getFromJson(Map data, int id) {
  //   int? newSelectedUser;
  //   if (data['pawn_gamer_id'] != null) {
  //     newSelectedUser = data['pawn_gamer_id'];
  //   }
  //   return ChessPieceModel(
  //     id: id,
  //     currentStatuses: currentStatuses,
  //     selectedUser: newSelectedUser,
  //   );
  // }
}
