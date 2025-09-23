import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Routes/server_routes.dart';
import 'package:refreshed/refreshed.dart';
import 'package:socket_io_client/socket_io_client.dart';

class LobbySocketManager extends BaseController {
  late Socket socket;

  void initSocket({
    required Function(dynamic) commandHandler,
    required Function(dynamic) reactionHandler,
    required Function onQueueError,
  }) {
    socket = io(ServerRoutes.lobbySocket, <String, dynamic>{
      'autoConnect': false,
      'timeout': 10000,
      'connect_timeout': 10000,
      'transports': ['websocket'],
      'auth': {'token': Get.find<GlobalController>().token.value ?? ""},
    });
    socket.connect();
    socket.onConnect((_) {
      debugPrint('connect');
    });
    socket.on(SocketChannels.serverCommand, (data) {
      debugPrint(data);
      commandHandler(data);
    });
    socket.on(SocketChannels.serverReaction, (data) {
      debugPrint(data);
      reactionHandler(data);
    });
    socket.onDisconnect((_) => debugPrint('disconnect'));
    socket.onConnectError((one) {
      onQueueError();
    });
  }

  void sendCommand(Map data) {
    debugPrint(data.toString());
    socket.emit(SocketChannels.userCommand, data);
  }

  void sendReaction(int data) {
    socket.emit(SocketChannels.userReaction, data);
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
