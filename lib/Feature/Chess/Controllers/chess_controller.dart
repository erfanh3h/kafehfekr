import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
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

  RxInt equippedPeaceIndex = RxInt(-1);

  late (int, int) king1Position;
  late (int, int) king2Position;

  Map<int, List<(int, int)>> currentPiecesMoves = {};
  Map<int, List<(int, int)>> currentPiecesHits = {};

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
    currentPiecesMoves.clear();
    currentPiecesHits.clear();
    int turn = data['data'];
    currentTurn.value = turn;
    if (turn == myGameId) {
      canSelectPeace.value = true;
      showInteraction(sound: GameSoundTypes.startTurn);
      setPiecesMovements();
    } else {
      canSelectPeace.value = false;
    }
    releasePeace();
    removeAllPeacesStatus(PeaceStatusTypes.selected);
    // add king check status to ui (selected)
    (int, int) kingPosition;
    if (turn == 1) {
      kingPosition = king1Position;
    } else {
      kingPosition = king2Position;
    }
    final List<(int, int)> kingChecks = getKingChecks(turn);
    if (kingChecks.isNotEmpty) {
      int index = coordinateToIndex(kingPosition);
      addPeaceStatus(index, PeaceStatusTypes.selected);
    }
    changetimerValue(GameWaitTimes.chessTurnTime);
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map selectionData = data['data']['select_data'];
    final sourceCIndex = selectionData['s_c_index'];
    final sourceRIndex = selectionData['s_r_index'];
    final targetCIndex = selectionData['t_c_index'];
    final targetRIndex = selectionData['t_r_index'];
    final (int, int) sourcePosition = (sourceCIndex, sourceRIndex);
    final (int, int) targetPosition = (targetCIndex, targetRIndex);
    final int gamerId = selectionData['gamer_id'];
    movePiece(sourcePosition, targetPosition, gamerId);
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
    List boardData = gameData['board_data'];
    currentTurn.value = gameData['current_turn'];
    for (var i = 0; i < boardData.length; i++) {
      peaces[i].value = peaces[i].value.getFromJson(boardData[i], i);
    }
    if (currentTurn.value == myGameId) {
      canSelectPeace.value = true;
      setPiecesMovements();
    } else {
      canSelectPeace.value = false;
    }
    if (timerData['is_user_turn']) {
      final int time = GameWaitTimes.chessTurnTime - timerData['time'] as int;
      changetimerValue(time.clamp(1, GameWaitTimes.chessTurnTime));
    }
  }

  // @override
  // void onEachButtonTap(dynamic tappedPeace) {
  //   myGameId = 2;
  //   ChessSpotModel peace = tappedPeace as ChessSpotModel;

  //   if (equippedPeaceIndex.value != -1) {
  //     if (equippedPeaceIndex.value == peace.id) {
  //       releasePeace();
  //     } else if (peace.piece.gamerId == myGameId) {
  //       releasePeace();
  //       equipPeace(peace.id);
  //     } else {
  //       if (!peace.currentStatuses.contains(PeaceStatusTypes.canSelected) &&
  //           !peace.currentStatuses.contains(PeaceStatusTypes.canHitted)) {
  //         Get.find<SoundPlayerComponent>()
  //             .playGameSound(GameSoundTypes.tapWrong);
  //         return;
  //       }
  //       final sourcePosition = indexToCoordinate(equippedPeaceIndex.value);
  //       final targetPosition = indexToCoordinate(peace.id);
  //       movePiece(sourcePosition, targetPosition, myGameId);
  //       releasePeace();
  //     }
  //   } else {
  //     if (peace.piece.gamerId != 0) {
  //       equipPeace(peace.id);
  //     }
  //   }
  // }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    // myGameId = 2;
    ChessSpotModel peace = tappedPeace as ChessSpotModel;
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    if (equippedPeaceIndex.value != -1) {
      if (equippedPeaceIndex.value == peace.id) {
        releasePeace();
      } else if (peace.piece.gamerId == myGameId) {
        releasePeace();
        equipPeace(peace.id);
      } else {
        if (!peace.currentStatuses.contains(PeaceStatusTypes.canSelected) &&
            !peace.currentStatuses.contains(PeaceStatusTypes.canHitted)) {
          showInteraction(text: AppTexts.cantSelect.tr);
          return;
        }
        final sourcePosition = indexToCoordinate(equippedPeaceIndex.value);
        final targetPosition = indexToCoordinate(peace.id);
        sendCommand({
          "id": GameCommands.selectPeace,
          "data": {
            's_c_index': sourcePosition.$1,
            's_r_index': sourcePosition.$2,
            't_c_index': targetPosition.$1,
            't_r_index': targetPosition.$2,
          }
        });
        releasePeace();
      }
    } else {
      if (peace.piece.gamerId != 0 && peace.piece.gamerId == myGameId) {
        equipPeace(peace.id);
      }
    }
  }

  void equipPeace(int index) {
    if (!currentPiecesMoves.keys.contains(index) &&
        !currentPiecesHits.keys.contains(index)) {
      return;
    }
    equippedPeaceIndex.value = index;
    addPeaceStatus(index, PeaceStatusTypes.equiped);
    for (var rawIndex in currentPiecesMoves[index]!) {
      int position = coordinateToIndex(rawIndex);
      addPeaceStatus(position, PeaceStatusTypes.canSelected);
    }
    for (var rawIndex in currentPiecesHits[index]!) {
      int position = coordinateToIndex(rawIndex);
      addPeaceStatus(position, PeaceStatusTypes.canHitted);
    }
  }

  void releasePeace() {
    try {
      removePeaceStatus(equippedPeaceIndex.value, PeaceStatusTypes.equiped);
    } catch (_) {}
    removeAllPeacesStatus(PeaceStatusTypes.canSelected);
    removeAllPeacesStatus(PeaceStatusTypes.canHitted);
    equippedPeaceIndex.value = -1;
  }

  List<(int, int)> addPossibleMoves(
      int index, int enemyId, (int, int) kingPosition) {
    List<(int, int)> result = [];
    List<(int, int)> enemyPieces = getEnemyPositions(enemyId);
    (int, int) position = indexToCoordinate(index);
    List<(int, int)> movesPossibleList =
        getPossibleMovesOfPeace(position, myGameId);
    for (var dataRaw in movesPossibleList) {
      (int, int) newPosition = dataRaw;
      bool canSelected = true;
      for (var checkPosition in enemyPieces) {
        final result = getPossibleHitsOfPeaceWithChangedPosition(
            checkPosition, enemyId, position, newPosition);
        if ((kingPosition == position) && result.contains(newPosition)) {
          canSelected = false;
          break;
        }
        if (result.contains(kingPosition)) {
          canSelected = false;
          break;
        }
      }
      if (canSelected) {
        result.add(newPosition);
      }
    }
    return result;
  }

  List<(int, int)> addPossibleHits(
      int index, int enemyId, (int, int) kingPosition) {
    List<(int, int)> result = [];

    List<(int, int)> enemyPieces = getEnemyPositions(enemyId);
    (int, int) position = indexToCoordinate(index);
    List<(int, int)> movesPossibleList =
        getPossibleHitsOfPeace(position, myGameId);
    for (var dataRaw in movesPossibleList) {
      (int, int) newPosition = dataRaw;
      bool canSelected = true;
      for (var checkPosition in enemyPieces) {
        final result = getPossibleHitsOfPeaceWithChangedPosition(
            checkPosition, enemyId, position, newPosition);
        if ((kingPosition == position) && result.contains(newPosition)) {
          canSelected = false;
          break;
        }
        if (result.contains(kingPosition)) {
          if (newPosition == checkPosition) {
            result.add(newPosition);
            break;
          }
          canSelected = false;
          break;
        }
      }
      if (canSelected) {
        result.add(newPosition);
      }
    }
    return result;
  }

  setPiecesMovements() {
    List<int> myPiecesindexes = getMyPiecesIndexes();
    int enemyId = 2;
    if (myGameId == 2) {
      enemyId = 1;
    }
    late (int, int) kingPosition;
    if (enemyId == 1) {
      kingPosition = king2Position;
    } else {
      kingPosition = king1Position;
    }
    for (var index in myPiecesindexes) {
      List<(int, int)> moves = addPossibleMoves(index, enemyId, kingPosition);
      List<(int, int)> hites = addPossibleHits(index, enemyId, kingPosition);
      currentPiecesMoves[index] = moves;
      currentPiecesHits[index] = hites;
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
    king1Position = (0, 4);
    king2Position = (7, 4);
  }

  bool isTargetPieceMine((int, int) position, int gamerId) {
    int index = coordinateToIndex(position);
    return peaces[index].value.piece.gamerId == gamerId;
  }

  bool isTargetPieceEmpty((int, int) position) {
    int index = coordinateToIndex(position);
    return peaces[index].value.piece.gamerId == 0;
  }

  bool isTargetPieceEnemy((int, int) position, int gamerId) {
    int index = coordinateToIndex(position);
    return peaces[index].value.piece.gamerId != 0 &&
        peaces[index].value.piece.gamerId != gamerId;
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
          // check for castle move that king side must be empty
          if ((move.$1, move.$2) == (0, 2) && !isTargetPieceEmpty((y, x - 1))) {
            continue;
          }
          // check for castle move that king side must be empty
          if ((move.$1, move.$2) == (0, -2) &&
              !isTargetPieceEmpty((y, x + 1))) {
            continue;
          }
          if (isValidCoordinate(y, x) && isTargetPieceEmpty((y, x))) {
            result.add((y, x));
          }
        }
      }
    }
    return result;
  }

  List<(int, int)> getPossibleHitsOfPeace((int, int) position, int gamerId) {
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
              } else if (isTargetPieceMine((y, x), gamerId)) {
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

  List<(int, int)> getPossibleHitsOfPeaceWithChangedPosition(
      (int, int) position,
      int gamerId,
      (int, int) sourceChangedPosition,
      (int, int) targetChangedPosition) {
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
              if ((y, x) == sourceChangedPosition) {
                i += 1;
              } else if ((y, x) == targetChangedPosition) {
                result.add((y, x));
                break;
              } else {
                if (isTargetPieceEnemy((y, x), gamerId)) {
                  result.add((y, x));
                  break;
                } else if (isTargetPieceMine((y, x), gamerId)) {
                  break;
                } else {
                  i += 1;
                }
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
          if (isValidCoordinate(y, x)) {
            if ((y, x) == sourceChangedPosition) {
            } else if ((y, x) == targetChangedPosition) {
              result.add((y, x));
            } else {
              if (isTargetPieceEnemy((y, x), gamerId)) {
                result.add((y, x));
              }
            }
          }
        }
      }
    }
    return result;
  }

  List<(int, int)> getKingChecks(int gamerId) {
    List<(int, int)> result = [];
    (int, int) targetKingPosition;
    int enemyId = 1;
    if (gamerId == 1) {
      targetKingPosition = king1Position;
      enemyId = 2;
    } else {
      targetKingPosition = king2Position;
    }
    for (var piece in peaces) {
      (int, int) position = indexToCoordinate(piece.value.id);
      if (isTargetPieceMine(position, enemyId)) {
        List<(int, int)> resultList = getPossibleHitsOfPeace(position, enemyId);
        if (resultList.contains(targetKingPosition)) {
          result.add(position);
        }
      }
    }
    return result;
  }

  List<(int, int)> getEnemyPositions(int enemyId) {
    List<(int, int)> result = [];
    for (var piece in peaces) {
      if (piece.value.piece.gamerId == enemyId) {
        (int, int) position = indexToCoordinate(piece.value.id);
        result.add(position);
      }
    }
    return result;
  }

  List<int> getMyPiecesIndexes() {
    List<int> result = [];
    for (var piece in peaces) {
      if (piece.value.piece.gamerId == myGameId) {
        result.add(piece.value.id);
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

    // change pawn to queen when reach last col
    if (sourcePosition.$1 == 6 &&
        targetPosition.$1 == 7 &&
        peaces.value[sourceIndex].value.piece.name == 'Pawn') {
      final gamerId = peaces.value[sourceIndex].value.piece.gamerId;
      peaces.value[sourceIndex].value =
          peaces.value[sourceIndex].value.changePiece(
        newPiece: QueenPieceModel(
          gamerId: gamerId,
          isFirstMove: false,
        ),
      );
    }
    if (sourcePosition.$1 == 1 &&
        targetPosition.$1 == 0 &&
        peaces.value[sourceIndex].value.piece.name == 'Pawn') {
      final gamerId = peaces.value[sourceIndex].value.piece.gamerId;
      peaces.value[sourceIndex].value =
          peaces.value[sourceIndex].value.changePiece(
        newPiece: QueenPieceModel(
          gamerId: gamerId,
          isFirstMove: false,
        ),
      );
    }
    //
    final newPiece =
        peaces.value[sourceIndex].value.piece.copyWith(isFirstMove: false);
    peaces.value[targetIndex].value =
        peaces.value[targetIndex].value.changePiece(newPiece: newPiece);
    peaces.value[sourceIndex].value = peaces.value[sourceIndex].value
        .changePiece(newPiece: ChessPieceModel());

    if (sourceIndex == 60 && targetIndex == 58) {
      movePiece((7, 0), (7, 3), gamerId);
    }
    if (sourceIndex == 60 && targetIndex == 62) {
      movePiece((7, 7), (7, 5), gamerId);
    }
    if (sourceIndex == 4 && targetIndex == 6) {
      movePiece((0, 7), (0, 5), gamerId);
    }
    if (sourceIndex == 4 && targetIndex == 2) {
      movePiece((0, 0), (0, 3), gamerId);
    }
    if (gamerId == 1 && sourcePosition == king1Position) {
      king1Position = targetPosition;
    }
    if (gamerId == 2 && sourcePosition == king2Position) {
      king2Position = targetPosition;
    }
    return true;
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.Chess;
    initPeaces();
  }
}
