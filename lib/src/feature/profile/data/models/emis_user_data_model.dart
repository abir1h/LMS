import 'package:flutter/cupertino.dart';

@immutable
class EmisUserDataModel {
  final String instituteType;
  final String indexNumber;
  final String instituteName;
  final String workstationName;
  final String branchInstituteName;
  final String eiin;
  final String email;
  final String mobileNo;
  final String branchInstituteCategory;
  final String instituteCategory;
  final String serviceBreakInstitute;
  final String name;
  final String employeeStatus;
  final String designation;
  final String subject;
  final String dateOfBirth;
  final String firstJoinDate;
  final String joiningDatePresentInstitution;
  final String mpoDatePresentInstitution;
  final String mpoCode;
  final String firstMpoDate;
  final String lastMpoDate;
  final String salaryCode;
  final String bankAccount;
  final String bank;
  final String bankBranch;
  final String nid;
  final String pdsid;
  final String lastBasicSalary;
  final String stepName;
  final String basicSalary;
  final String netPayable;
  final bool isMpo;
  final bool isActive;
  final bool paymentStatus;
  final String code;
  final String message;
  final String token;
  final String marchantProfileResponse;

  const EmisUserDataModel({
    required this.instituteType,
    required this.indexNumber,
    required this.instituteName,
    required this.workstationName,
    required this.branchInstituteName,
    required this.eiin,
    required this.email,
    required this.mobileNo,
    required this.branchInstituteCategory,
    required this.instituteCategory,
    required this.serviceBreakInstitute,
    required this.name,
    required this.employeeStatus,
    required this.designation,
    required this.subject,
    required this.dateOfBirth,
    required this.firstJoinDate,
    required this.joiningDatePresentInstitution,
    required this.mpoDatePresentInstitution,
    required this.mpoCode,
    required this.firstMpoDate,
    required this.lastMpoDate,
    required this.salaryCode,
    required this.bankAccount,
    required this.bank,
    required this.bankBranch,
    required this.nid,
    required this.pdsid,
    required this.lastBasicSalary,
    required this.stepName,
    required this.basicSalary,
    required this.netPayable,
    required this.isMpo,
    required this.isActive,
    required this.paymentStatus,
    required this.code,
    required this.message,
    required this.token,
    required this.marchantProfileResponse,
  });

  factory EmisUserDataModel.fromJson(Map<String, dynamic> json) => EmisUserDataModel(
    instituteType: json["InstituteType"]??"",
    indexNumber: json["IndexNumber"]??"",
    instituteName: json["InstituteName"]??"",
    workstationName: json["WorkstationName"]??"",
    branchInstituteName: json["BranchInstituteName"]??"",
    eiin: json["EIIN"]??"",
    email: json["Email"]??"",
    mobileNo: json["MobileNo"]??"",
    branchInstituteCategory: json["BranchInstituteCategory"]??"",
    instituteCategory: json["InstituteCategory"]??"",
    serviceBreakInstitute: json["ServiceBreakInstitute"]??"",
    name: json["Name"]??"",
    employeeStatus: json["EmployeeStatus"]??"",
    designation: json["Designation"]??"",
    subject: json["Subject"]??"",
    dateOfBirth: json["DateOfBirth"]??"",
    firstJoinDate: json["FirstJoinDate"]??"",
    joiningDatePresentInstitution: json["JoiningDatePresentInstitution"]??"",
    mpoDatePresentInstitution: json["MPODatePresentInstitution"]??"",
    mpoCode: json["MPOCode"]??"",
    firstMpoDate: json["FirstMpoDate"]??"",
    lastMpoDate: json["LastMpoDate"]??"",
    salaryCode: json["SalaryCode"]??"",
    bankAccount: json["BankAccount"]??"",
    bank: json["Bank"]??"",
    bankBranch: json["BankBranch"]??"",
    nid: json["NID"]??"",
    pdsid: json["PDSID"]??"",
    lastBasicSalary: json["LastBasicSalary"]??"",
    stepName: json["StepName"]??"",
    basicSalary: json["Basic_Salary"]??"",
    netPayable: json["NetPayable"]??"",
    isMpo: json["IsMpo"]??false,
    isActive: json["IsActive"]??false,
    paymentStatus: json["PaymentStatus"]??false,
    code: json["Code"]??"",
    message: json["Message"]??"",
    token: json["_token"]??"",
    marchantProfileResponse: json["MarchantProfileResponse"]??"",
  );

  Map<String, dynamic> toJson() => {
    "InstituteType": instituteType,
    "IndexNumber": indexNumber,
    "InstituteName": instituteName,
    "WorkstationName": workstationName,
    "BranchInstituteName": branchInstituteName,
    "EIIN": eiin,
    "Email": email,
    "MobileNo": mobileNo,
    "BranchInstituteCategory": branchInstituteCategory,
    "InstituteCategory": instituteCategory,
    "ServiceBreakInstitute": serviceBreakInstitute,
    "Name": name,
    "EmployeeStatus": employeeStatus,
    "Designation": designation,
    "Subject": subject,
    "DateOfBirth": dateOfBirth,
    "FirstJoinDate": firstJoinDate,
    "JoiningDatePresentInstitution": joiningDatePresentInstitution,
    "MPODatePresentInstitution": mpoDatePresentInstitution,
    "MPOCode": mpoCode,
    "FirstMpoDate": firstMpoDate,
    "LastMpoDate": lastMpoDate,
    "SalaryCode": salaryCode,
    "BankAccount": bankAccount,
    "Bank": bank,
    "BankBranch": bankBranch,
    "NID": nid,
    "PDSID": pdsid,
    "LastBasicSalary": lastBasicSalary,
    "StepName": stepName,
    "Basic_Salary": basicSalary,
    "NetPayable": netPayable,
    "IsMpo": isMpo,
    "IsActive": isActive,
    "PaymentStatus": paymentStatus,
    "Code": code,
    "Message": message,
    "_token": token,
    "MarchantProfileResponse": marchantProfileResponse,
  };
}