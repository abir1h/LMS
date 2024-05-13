import '../../domain/entities/emis_user_data_entity.dart';
import '../models/emis_user_data_model.dart';

abstract class EmisUserDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _EmisUserDataModelToEntityMapper
    extends EmisUserDataMapper<EmisUserDataModel, EmisUserDataEntity> {
  @override
  EmisUserDataModel fromEntityToModel(EmisUserDataEntity entity) {
    return EmisUserDataModel(
        instituteType: entity.instituteType,
        indexNumber: entity.indexNumber,
        instituteName: entity.instituteName,
        workstationName: entity.workstationName,
        branchInstituteName: entity.branchInstituteName,
        eiin: entity.eiin,
        email: entity.email,
        mobileNo: entity.mobileNo,
        branchInstituteCategory: entity.branchInstituteCategory,
        instituteCategory: entity.instituteCategory,
        serviceBreakInstitute: entity.serviceBreakInstitute,
        name: entity.name,
        employeeStatus: entity.employeeStatus,
        designation: entity.designation,
        subject: entity.subject,
        dateOfBirth: entity.dateOfBirth,
        firstJoinDate: entity.firstJoinDate,
        joiningDatePresentInstitution: entity.joiningDatePresentInstitution,
        mpoDatePresentInstitution: entity.mpoDatePresentInstitution,
        mpoCode: entity.mpoCode,
        firstMpoDate: entity.firstMpoDate,
        lastMpoDate: entity.lastMpoDate,
        salaryCode: entity.salaryCode,
        bankAccount: entity.bankAccount,
        bank: entity.bank,
        bankBranch: entity.bankBranch,
        nid: entity.nid,
        pdsid: entity.pdsid,
        lastBasicSalary: entity.lastBasicSalary,
        stepName: entity.stepName,
        basicSalary: entity.basicSalary,
        netPayable: entity.netPayable,
        isMpo: entity.isMpo,
        isActive: entity.isActive,
        paymentStatus: entity.paymentStatus,
        code: entity.code,
        message: entity.message,
        token: entity.token,
        marchantProfileResponse: entity.marchantProfileResponse);
  }

  @override
  EmisUserDataEntity toEntityFromModel(EmisUserDataModel model) {
    return EmisUserDataEntity(
        instituteType: model.instituteType,
        indexNumber: model.indexNumber,
        instituteName: model.instituteName,
        workstationName: model.workstationName,
        branchInstituteName: model.branchInstituteName,
        eiin: model.eiin,
        email: model.email,
        mobileNo: model.mobileNo,
        branchInstituteCategory: model.branchInstituteCategory,
        instituteCategory: model.instituteCategory,
        serviceBreakInstitute: model.serviceBreakInstitute,
        name: model.name,
        employeeStatus: model.employeeStatus,
        designation: model.designation,
        subject: model.subject,
        dateOfBirth: model.dateOfBirth,
        firstJoinDate: model.firstJoinDate,
        joiningDatePresentInstitution: model.joiningDatePresentInstitution,
        mpoDatePresentInstitution: model.mpoDatePresentInstitution,
        mpoCode: model.mpoCode,
        firstMpoDate: model.firstMpoDate,
        lastMpoDate: model.lastMpoDate,
        salaryCode: model.salaryCode,
        bankAccount: model.bankAccount,
        bank: model.bank,
        bankBranch: model.bankBranch,
        nid: model.nid,
        pdsid: model.pdsid,
        lastBasicSalary: model.lastBasicSalary,
        stepName: model.stepName,
        basicSalary: model.basicSalary,
        netPayable: model.netPayable,
        isMpo: model.isMpo,
        isActive: model.isActive,
        paymentStatus: model.paymentStatus,
        code: model.code,
        message: model.message,
        token: model.token,
        marchantProfileResponse: model.marchantProfileResponse);
  }
}

extension EmisUserDataModelExt on EmisUserDataModel {
  EmisUserDataEntity get toEmisUserDataEntity =>
      _EmisUserDataModelToEntityMapper().toEntityFromModel(this);
}

extension EmisUserDataEntityExt on EmisUserDataEntity {
  EmisUserDataModel get toEmisUserDataModel =>
      _EmisUserDataModelToEntityMapper().fromEntityToModel(this);
}
