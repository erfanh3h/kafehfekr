import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/Chess/Models/Pieces/bishop_piece_model.dart';
import 'package:kafehfekr/Feature/Chess/Models/Pieces/king_piece_model.dart';
import 'package:kafehfekr/Feature/Chess/Models/Pieces/knight_piece_model.dart';
import 'package:kafehfekr/Feature/Chess/Models/Pieces/pawn_piece_model.dart';
import 'package:kafehfekr/Feature/Chess/Models/Pieces/queen_piece_model.dart';
import 'package:kafehfekr/Feature/Chess/Models/Pieces/rook_piece_model.dart';
import 'package:kafehfekr/Feature/Chess/Models/chess_piece_model.dart';
import 'package:kafehfekr/Feature/Chess/Models/chess_spot_piece_model.dart';
import 'package:refreshed/refreshed.dart';

class ChessController extends BaseGameController {
  RxList<Rx<ChessSpotModel>> peaces = RxList();
  RxInt player1Pawns = RxInt(16);
  RxInt player2Pawns = RxInt(16);

  RxInt equippedPeaceIndex = RxInt(-1);

  List checkMoveList = [];
  List currentPossibleMoves = [];

  (int, int) indexToCoordinate(int index) {
    final x = index % 8;
    final y = index ~/ 8;
    return (y, x);
  }

  int coordinateToIndex((int, int) position) {
    final index = position.$1 * 8 + position.$2;
    return index;
  }

  @override
  void currentTurnFunction(Map data) {
    int turn = data['data'];
    currentTurn.value = turn;
    if (turn == myGameId) {
      canSelectPeace.value = true;
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.startTurn);
    } else {
      canSelectPeace.value = false;
    }
    changetimerValue(GameWaitTimes.checkersTurnTime);
    releasePeace();
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map selectionData = data['data']['select_data'];
    final sourceRIndex = selectionData['s_r_index'];
    final sourceCIndex = selectionData['s_c_index'];
    final targetRIndex = selectionData['t_r_index'];
    final targetCIndex = selectionData['t_c_index'];
    final int gamerId = selectionData['gamer_id'];
    // final index = coordinateToIndex(sourceRIndex, sourceCIndex);
    // addPossibleMoves(index);
    // final moveResult = movePiece(
    //     sourceCIndex, sourceRIndex, targetCIndex, targetRIndex, gamerId);
    // if (moveResult) {
    //   releasePeace();
    // }
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    currentTurn.value = gameData['current_turn'];
    player1Pawns.value = gameData['pawns_count'][0];
    player2Pawns.value = gameData['pawns_count'][1];
    for (var i = 0; i < boardData.length; i++) {
      peaces[i].value = peaces[i].value.getFromJson(boardData[i], i);
    }
    if (currentTurn.value == myGameId) {
      canSelectPeace.value = true;
    } else {
      canSelectPeace.value = false;
    }
    if (timerData['is_user_turn']) {
      final int time = GameWaitTimes.millSelectTime - timerData['time'] as int;
      changetimerValue(time.clamp(1, GameWaitTimes.millSelectTime));
    }
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    myGameId = 2;
    ChessSpotModel peace = tappedPeace as ChessSpotModel;
    // if (!canSelectPeace.value) {
    //   Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
    //   return;
    // }
    if (equippedPeaceIndex.value != -1) {
      if (equippedPeaceIndex.value == peace.id) {
        releasePeace();
      } else if (peace.piece.gamerId == myGameId) {
        releasePeace();
        equipPeace(peace.id);
      } else {
        if (!peace.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
          Get.find<SoundPlayerComponent>()
              .playGameSound(GameSoundTypes.tapWrong);
          return;
        }

        final sourcePosition = indexToCoordinate(equippedPeaceIndex.value);
        final targetPosition = indexToCoordinate(peace.id);
        movePiece(sourcePosition, targetPosition, 2);
        releasePeace();
        // final List sourceData = indexToCoordinate(equippedPeaceIndex.value);
        // final sourceRIndex = sourceData[0];
        // final sourceCIndex = sourceData[1];s
        // final List targetData = indexToCoordinate(peace.id);
        // final targetRIndex = targetData[0];
        // final targetCIndex = targetData[1];
        // sendCommand({
        //   "id": GameCommands.selectPeace,
        //   "data": {
        //     's_c_index': sourceCIndex,
        //     's_r_index': sourceRIndex,
        //     't_c_index': targetCIndex,
        //     't_r_index': targetRIndex,
        //   }
        // });
        // releasePeace();
        // final moveResult = movePiece(
        //     sourceCIndex, sourceRIndex, targetCIndex, targetRIndex, myGameId);
        // if (moveResult) {
        //   releasePeace();
        // }
      }
    } else {
      if (peace.piece.gamerId != 0 && peace.piece.gamerId == myGameId) {
        equipPeace(peace.id);
      }
    }
  }

  void equipPeace(int index) {
    equippedPeaceIndex.value = index;
    addPeaceStatus(index, PeaceStatusTypes.equiped);
    addPossibleMoves(index);
  }

  void releasePeace() {
    try {
      removePeaceStatus(equippedPeaceIndex.value, PeaceStatusTypes.equiped);
    } catch (_) {}
    removeAllPeacesStatus(PeaceStatusTypes.canSelected);
    equippedPeaceIndex.value = -1;
    currentPossibleMoves.clear();
  }

  void addPossibleMoves(int index) {
    (int, int) position = indexToCoordinate(index);
    List<(int, int)> movesPossibleList =
        getPossibleMovesOfPeace(position, myGameId);
    for (var dataRaw in movesPossibleList) {
      (int, int) coordinates = dataRaw;
      final peaceId = coordinateToIndex(coordinates);
      addPeaceStatus(peaceId, PeaceStatusTypes.canSelected);
      currentPossibleMoves.add(dataRaw);
    }
  }

  void resetPeaces() {
    for (var i = 0; i < peaces.length; i++) {
      peaces[i].value = peaces[i].value.resetPeace();
    }
  }

  addPeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.addStatus(status: status);
  }

  removePeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.removeStatus(status: status);
  }

  removeAllPeacesStatus(PeaceStatusTypes status) {
    for (var i = 0; i < peaces.length; i++) {
      peaces.value[i].value =
          peaces.value[i].value.removeStatus(status: status);
    }
  }

  addSpotPiece(int peaceId, ChessPieceModel piece) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.changePiece(newPiece: piece);
  }

  initPeaces() {
    for (var i = 0; i < 64; i++) {
      peaces.add(
        Rx(ChessSpotModel(
            id: i, currentStatuses: [], piece: ChessPieceModel())),
      );
    }
    int index = 0;
    addSpotPiece(index, RookPieceModel(gamerId: 1));
    index += 1;
    addSpotPiece(index, KnightPieceModel(gamerId: 1));
    index += 1;
    addSpotPiece(index, BishopPieceModel(gamerId: 1));
    index += 1;
    addSpotPiece(index, QueenPieceModel(gamerId: 1));
    index += 1;
    addSpotPiece(index, KingPieceModel(gamerId: 1));
    index += 1;
    addSpotPiece(index, BishopPieceModel(gamerId: 1));
    index += 1;
    addSpotPiece(index, KnightPieceModel(gamerId: 1));
    index += 1;
    addSpotPiece(index, RookPieceModel(gamerId: 1));
    index += 1;
    for (var i = 0; i < 8; i++) {
      addSpotPiece(index, PawnPieceModel(gamerId: 1));
      index += 1;
    }
    index += 32;
    for (var i = 0; i < 8; i++) {
      addSpotPiece(index, PawnPieceModel(gamerId: 2));
      index += 1;
    }
    addSpotPiece(index, RookPieceModel(gamerId: 2));
    index += 1;
    addSpotPiece(index, KnightPieceModel(gamerId: 2));
    index += 1;
    addSpotPiece(index, BishopPieceModel(gamerId: 2));
    index += 1;
    addSpotPiece(index, QueenPieceModel(gamerId: 2));
    index += 1;
    addSpotPiece(index, KingPieceModel(gamerId: 2));
    index += 1;
    addSpotPiece(index, BishopPieceModel(gamerId: 2));
    index += 1;
    addSpotPiece(index, KnightPieceModel(gamerId: 2));
    index += 1;
    addSpotPiece(index, RookPieceModel(gamerId: 2));
  }

  bool isTargetPieceEmpty((int, int) position) {
    int index = coordinateToIndex(position);
    return peaces[index].value.piece.gamerId == 0;
  }

  bool isTargetPieceEnemy((int, int) position, int gamerId) {
    int index = coordinateToIndex(position);
    return peaces[index].value.piece.gamerId != gamerId;
  }

  List getDirectionMovesList(
      int rIndex, int cIndex, int gamerId, int direction) {
    List<List> tempList = [];
    return tempList;
  }

  bool isValidCoordinate(int y, int x) {
    return x >= 0 && x < 8 && y >= 0 && y < 8;
  }

  List<(int, int)> getPossibleMovesOfPeace((int, int) position, int gamerId) {
    List<(int, int)> result = [];
    int spotIndex = coordinateToIndex(position);
    if (!isTargetPieceEmpty(position)) {
      final List<(int, int)> pieceMoveList =
          peaces.value[spotIndex].value.piece.getMovesList();
      final bool isPieceMultiMove =
          peaces.value[spotIndex].value.piece.isMultiMove;
      if (isPieceMultiMove) {
        for (var move in pieceMoveList) {
          int i = 1;
          while (true) {
            int y = position.$1 + (move.$1 * i);
            int x = position.$2 + (move.$2 * i);
            if (isValidCoordinate(y, x)) {
              if (!isTargetPieceEmpty((y, x))) {
                break;
              } else {
                result.add((y, x));
                i += 1;
              }
            } else {
              break;
            }
          }
        }
      } else {
        for (var move in pieceMoveList) {
          int y = position.$1 + move.$1;
          int x = position.$2 + move.$2;
          if (isValidCoordinate(y, x) && isTargetPieceEmpty((y, x))) {
            result.add((y, x));
          }
        }
      }
    }
    return result;
  }

  List getPossibleHitsOfPeace((int, int) position, int gamerId) {
    List<(int, int)> result = [];
    int spotIndex = coordinateToIndex(position);
    if (!isTargetPieceEmpty(position)) {
      final List<(int, int)> pieceMoveList =
          peaces.value[spotIndex].value.piece.getHitsList();
      final bool isPieceMultiMove =
          peaces.value[spotIndex].value.piece.isMultiMove;
      if (isPieceMultiMove) {
        for (var move in pieceMoveList) {
          int i = 1;
          while (true) {
            int y = position.$1 + (move.$1 * i);
            int x = position.$2 + (move.$2 * i);
            if (isValidCoordinate(y, x)) {
              if (isTargetPieceEnemy((y, x), gamerId)) {
                result.add((y, x));
                break;
              } else {
                i += 1;
              }
            } else {
              break;
            }
          }
        }
      } else {
        for (var move in pieceMoveList) {
          int y = position.$1 + move.$1;
          int x = position.$2 + move.$2;
          if (isValidCoordinate(y, x) && isTargetPieceEnemy((y, x), gamerId)) {
            result.add((y, x));
          }
        }
      }
    }
    return result;
  }

  bool checkIsLastPeace(cIndex, gamerId) {
    if (gamerId == 1) {
      if (cIndex == 7) {
        return true;
      }
      return false;
    } else {
      if (cIndex == 0) {
        return true;
      }
      return false;
    }
  }

  bool movePiece(
      (int, int) sourcePosition, (int, int) targetPosition, int gamerId) {
    final sourceIndex = coordinateToIndex(sourcePosition);
    final targetIndex = coordinateToIndex(targetPosition);
    final newPiece =
        peaces.value[sourceIndex].value.piece.copyWith(isFirstMove: false);
    peaces.value[targetIndex].value =
        peaces.value[targetIndex].value.changePiece(newPiece: newPiece);
    peaces.value[sourceIndex].value = peaces.value[sourceIndex].value
        .changePiece(newPiece: ChessPieceModel());
    return true;
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.chess;
    initPeaces();
  }
}
