
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/server_routes.dart';
import 'package:kafehfekr/Feature/Game/Core/game_repository.dart';
import 'package:kafehfekr/Feature/Game/Models/player_model.dart';
import 'package:kafehfekr/Feature/Game/Models/status_types.dart';
import 'package:refreshed/refreshed.dart';

import '../../../Core/Base/base_controller.dart';
import 'package:socket_io_client/socket_io_client.dart';

class GameBoardController extends BaseController {
  final GameRepository _gameRepo;

  GameBoardController(this._gameRepo);

  RxString logText = RxString('');

  late Socket socket;
  // List<PlayerModel> players = [
  RxList<Rx<PlayerModel>> players = RxList();

  int? myId = 1;


  Rx<GameStatusTypes> gameStatus = Rx(GameStatusTypes.none);

  Rx<GamePlayersSelectionTypes> selectionType =
      Rx(GamePlayersSelectionTypes.none);

  PlayerModel returnPlayerById(int index) {
    switch (index) {
      case 0:
        return players.value[0].value;
      default:
        return players.value[0].value;
    }
  }

  void setPlayerData(int index, PlayerModel playerData) {
    switch (index) {}
  }

  void commandHandler(dynamic data) {
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.gameData:
        // Map gameData = data['data'];
        break;
      default:
    }
  }

  void sendCommand(Map data) {
    socket.emit(SocketChannels.userCommand, data);
  }

  void initSocket() {
    socket = io(ServerRoutes.gameSocket, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
      'auth': {'name': 'mobile'},
    });
    socket.connect();
    socket.onConnect((_) {
      print('connect');
    });
    socket.on('message', (data) => print(data));
    socket.on('command', (data) {
      print(data);
      commandHandler(data);
    });
    socket.onDisconnect((_) => print('disconnect'));
  }

  @override
  void onInit() async {
    initSocket();
    super.onInit();
  }
}
