import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Routes/server_routes.dart';
import 'package:refreshed/refreshed.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../Global/Controllers/global_controller.dart';

class GameSocketManager extends BaseController {
  late Socket socket;

  void initSocket(
      {required Function(dynamic) commandHandler,
      required Function(dynamic) reactionHandler,
      required String myId,
      required String gameId}) {
    socket = io(ServerRoutes.gameSocket, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
      'auth': {
        'user_id': myId,
        'game_id': gameId,
        'token': Get.find<GlobalController>().token ?? ""
      },
    });
    socket.connect();
    socket.onConnect((_) {
      print('connect');
    });
    socket.on(SocketChannels.serverReaction, (data) {
      reactionHandler(data);
    });

    socket.on(SocketChannels.serverCommand, (data) {
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

  void changeCommandHandler({required Function(dynamic) commandHandler}) {
    socket.off(SocketChannels.serverCommand);
    Future.delayed(const Duration(milliseconds: 10)).then((_) {
      socket.on(SocketChannels.serverCommand, (data) {
        commandHandler(data);
      });
    });
  }

  void changeReactionHandler({required Function(dynamic) reactionHandler}) {
    socket.off(SocketChannels.serverReaction);
    Future.delayed(const Duration(milliseconds: 10)).then((_) {
      socket.on(SocketChannels.serverReaction, (data) {
        reactionHandler(data);
      });
    });
  }

  void disconnect() {
    socket.disconnect();
  }

  @override
  // ignore: invalid_override_of_non_virtual_member
  void onClose() {
    socket.dispose();
    super.onDelete();
  }
}
