import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Routes/server_routes.dart';
import 'package:socket_io_client/socket_io_client.dart';

class GameSocketManager extends GlobalController {
  late Socket socket;

  void initSocket({
    required Function(dynamic) commandHandler,
    required Function(dynamic) reactionHandler,
    int myId = 1,
    String gameId = "gameId",
  }) {
    socket = io(ServerRoutes.gameSocket, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
      'auth': {'user_id': myId, 'game_id': gameId},
    });
    socket.connect();
    socket.onConnect((_) {
      print('connect');
    });
    socket.on(SocketChannels.serverReaction, (data) {
      print(data);
      reactionHandler(data);
    });

    socket.on(SocketChannels.serverCommand, (data) {
      print(data);
      commandHandler(data);
    });
    socket.onDisconnect((_) => print('disconnect'));
  }

  void sendCommand(Map data) {
    socket.emit(SocketChannels.userCommand, data);
  }

  void sendReaction(int data) {
    socket.emit(SocketChannels.userReaction, data);
  }

  void disconnect() {
    socket.disconnect();
  }
}
