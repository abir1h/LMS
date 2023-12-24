import 'package:get/get.dart';

class AssignmentController extends GetxController {
  RxString filename=''.obs;
  RxBool isUpload = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  getShortenedFileName(String filePath) {
    // Set the maximum length for the displayed file name
    const int maxFileNameLength = 20;

    String fileName = filePath.split('/').last; // Extract the file name
    return fileName.length > maxFileNameLength
        ? '${fileName.substring(0, maxFileNameLength)}...'
        : fileName;
  }
}
