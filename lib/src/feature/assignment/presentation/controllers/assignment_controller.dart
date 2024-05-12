import 'package:get/get.dart';
import 'package:lms/src/feature/assignment/presentation/models/assignment_model.dart';

class AssignmentController extends GetxController {
  RxString filename = ''.obs;
  RxBool isUpload = false.obs;

  String data = '';
  setContentToText(AssignmentModel mainModel) {
    data = mainModel.content!;
    update();
  }

  AssignmentModel? assignmentModel;
  setContent(AssignmentModel data) {
    assignmentModel = data;

    update();
  }

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
