import 'package:pivot_chat/manager/base_box_manager.dart';
import 'package:pivot_chat/model/message.dart';
import 'package:utils/logger.dart';

final messageManager = PCMessageManager._();

class PCMessageManager with PCBaseBoxManager<int, PCMessage> {
  PCMessageManager._() {
    logger.i('PCMessageManager init');
  }
}
