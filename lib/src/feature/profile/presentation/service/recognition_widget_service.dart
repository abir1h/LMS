import 'package:flutter/material.dart';

import '../../../../core/utility/app_label.dart';
import '../../domain/entities/certificate_data_entity.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../data/data_sources/remote/profile_data_source.dart';
import '../../data/repositories/profile_repository_imp.dart';
import '../../domain/use_cases/profile_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
}

mixin RecognitionWidgetService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final ProfileUseCase _profileUseCase = ProfileUseCase(
      profileRepository: ProfileRepositoryImp(
          profileRemoteDataSource: ProfileRemoteDataSourceImp()));

  Future<ResponseEntity> getCertificate() async {
    return _profileUseCase.getCertificateUseCase();
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    _loadCertificateData();
  }

  @override
  void dispose() {
    certificateDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<CertificateDataEntity>
      certificateDataStreamController = AppStreamController();

  ///Load Certificate data
  void _loadCertificateData() {
    if (!mounted) return;
    certificateDataStreamController.add(LoadingState());
    getCertificate().then((value) {
      if (value.error == null && value.data != null) {
        certificateDataStreamController
            .add(DataLoadedState<CertificateDataEntity>(value.data));
      } else if (value.error == null && value.data == null) {
        certificateDataStreamController.add(EmptyState(
            message: label(
                e: "No Certificate Found",
                b: "কোন সার্টিফিকেট পাওয়া যায়নি")));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}
