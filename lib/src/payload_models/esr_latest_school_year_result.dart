import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRLatestSchoolYearResult{
  String status;
  ESRSchoolYear schoolYear;

  ESRLatestSchoolYearResult({
    required this.status,
    required this.schoolYear
  });

  factory ESRLatestSchoolYearResult.fromJson(Map<String, dynamic> json){
    return ESRLatestSchoolYearResult(
      status: json['status'],
      schoolYear: ESRSchoolYear.fromJson(json["school_year"])
    );
  }
}