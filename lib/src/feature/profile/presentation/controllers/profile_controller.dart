import 'package:get/get.dart';
import '../../domain/use_cases/profile_use_case.dart';

class ProfileController extends GetxController {
  ProfileController(this._profileUseCase);
  final ProfileUseCase _profileUseCase;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
