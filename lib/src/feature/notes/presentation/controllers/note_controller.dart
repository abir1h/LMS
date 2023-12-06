import 'package:get/get.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_routes.dart';
import '../models/note_model.dart';

class NoteController extends GetxController {
  final  edit = false.obs;
  final  noteIndex="";
  final keybaordFocused = false.obs;
  RxList<NoteModel> noteList=<NoteModel>[].obs;



  @override
  void onInit() {
    super.onInit();
  }

}
