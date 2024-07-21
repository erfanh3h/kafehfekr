import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/server_routes.dart';
import 'package:kafehfekr/Core/Global/Models/player_model.dart';
import 'package:kafehfekr/Core/Global/Models/status_types.dart';
import 'package:kafehfekr/Feature/TicTacToe/Models/tictactoe_peace_model.dart';
import 'package:refreshed/refreshed.dart';

import '../../../Core/Base/base_controller.dart';
import 'package:socket_io_client/socket_io_client.dart';

class TicTacToeController extends BaseController {
  TicTacToeController();

  RxString logText = RxString('');

  late Socket socket;
  // List<PlayerModel> players = [
  RxList<Rx<PlayerModel>> players = RxList();
  RxList<Rx<TicTacToePeaceModel>> peaces = RxList();

  int? myId = 1;

  RxBool canSelectPeace = RxBool(false);

  Rx<GameStatusTypes> gameStatus = Rx(GameStatusTypes.none);

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
        Map gameData = data['data'];
        print(gameData);
        break;
      case GameCommands.currentTurn:
        int currentTurn = data['data'];
        if (currentTurn == myId) {
          canSelectPeace.value = true;
        } else {
          canSelectPeace.value = false;
        }
        break;
      case GameCommands.peaceSelected:
        Map peaceData = data['data'];
        int peaceId = peaceData['target_peace'];
        for (final peace in peaces) {
          if (peace.value.id == peaceId) {
            peace.value = peace.value
                .changeSelectedUser(newSelectedUser: peaceData["user"]);
            break;
          }
        }
        break;
      default:
    }
  }

  void sendCommand(Map data) {
    socket.emit(SocketChannels.userCommand, data);
  }

  void onEachButtonTap(TicTacToePeaceModel peace) {
    if (!canSelectPeace.value) {
      print("not your turn");
      return;
    }
    if (peace.selectedUser != null) {
      print("selected before !");
      return;
    }
    sendCommand({"id": 'SelectPeace', "data": peace.id});
    print(peace.id);
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
    for (var i = 0; i < 9; i++) {
      peaces.add(Rx(TicTacToePeaceModel(id: i, currentStatuses: [])));
    }
    super.onInit();
  }
}
