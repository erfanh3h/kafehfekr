import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Routes/server_routes.dart';
import 'package:refreshed/refreshed.dart';
import 'package:socket_io_client/socket_io_client.dart';

class QueueSocketManager extends BaseController {
  late Socket socket;

  void initSocket({
    required Function(dynamic) commandHandler,
    required String myId,
    required Function onQueueStart,
    required Function onQueueError,
    String? preGameId,
  }) {
    socket = io(ServerRoutes.queueSocket, <String, dynamic>{
      'autoConnect': false,
      'timeout': 10000,
      'connect_timeout': 10000,
      'transports': ['websocket'],
      'auth': {
        'user_id': myId,
        'token': Get.find<GlobalController>().token.value ?? "",
        'pre_game_id': preGameId,
      },
    });
    socket.connect();
    socket.onConnect((_) {
      debugPrint('connect queue');
      onQueueStart();
    });
    // socket.onConnectTimeout((_) {
    //   print('timeout');
    // });
    socket.on(SocketChannels.serverCommand, (data) {
      debugPrint(data.toString());
      commandHandler(data);
    });
    // socket.onDisconnect((_) => print('disconnect'));
    socket.onConnectError((one) {
      onQueueError();
    });
  }

  void sendCommand(Map data) {
    socket.emit(SocketChannels.userCommand, data);
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
