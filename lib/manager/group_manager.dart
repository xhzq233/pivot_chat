import 'package:pivot_chat/manager/base_box_manager.dart';
import 'package:pivot_chat/model/group.dart';
import 'package:utils/logger.dart';

final groupManager = PCGroupManager._();

class PCGroupManager with PCBaseBoxManager<int, PCGroup> {
  PCGroupManager._() {
    logger.i('PCGroupManager init');
  }
}
