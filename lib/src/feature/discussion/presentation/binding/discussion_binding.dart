import 'package:get/get.dart';

import '../controller/discussion_controller.dart';
import '../controller/discussion_list_controller.dart';

class DiscussionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscussionController());
    Get.lazyPut(() => DiscussionListController());
  }
}
