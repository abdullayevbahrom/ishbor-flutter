import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/core/services/storage_service.dart';
import 'package:web_socket_channel/io.dart';

import '../../injection_container.dart';

class WebsocketClient {
  static Future<IOWebSocketChannel> initChat(int messageId) async {
    final String? token = await sl<StorageService>().fetchToken();
    return IOWebSocketChannel.connect(
      Uri.parse('${ApiConstants.wsUrl}/messages/$messageId?token=$token'),
    );
  }

  Future<void> initUserStatus({
    Function(dynamic)? onMessages,
    Function? onError,
  }) async {
    final String? token = await sl<StorageService>().fetchToken();
    IOWebSocketChannel.connect(
      Uri.parse("${ApiConstants.wsUrl}/users/statuses?token=$token"),
    );
  }
}
