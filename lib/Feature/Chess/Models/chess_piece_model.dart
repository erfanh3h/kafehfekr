class ChessPieceModel {
  ChessPieceModel({
    this.gamerId = 0,
    this.isMultiMove = true,
    this.isFirstMove = true,
  });

  int gamerId;
  bool isMultiMove;
  bool isFirstMove;

  List<(int, int)> getMovesList() {
    return [];
  }

  List<(int, int)> getHitsList() {
    return getMovesList();
  }
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
