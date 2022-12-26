enum SchoolCode {
  //강원도교육청
  K10,
  //경기도교육청
  J10,
  //경상남도교육청
  S10,
  //경상북도교육청
  R10,
  //광주광역시교육청
  F10,
  //대구광역시교육청
  D10,
  //대전광역시교육청
  G10,
  //부산광역시교육청
  C10,
  //서울특별시교육청
  B10,
  //세종특별자치시교육청
  I10,
  //울산광역시교육청
  H10,
  //인천광역시교육청
  E10,
  //전라남도교육청
  Q10,
  //전라북도교육청
  P10,
  //제주특별자치도교육청
  T10,
  //충청남도교육청
  N10,
  //충청북도교육청
  M10,
}

class MealModel {
  // 필요한 것들만 활성화 시켜 놓음 ex) 학교명, 요리명, 칼로리정보 등
  // final SchoolCode ATPT_OFCDC_SC_CODE;
  // final String ATPT_OFCDC_SC_NM;
  // final int SD_SCHUL_CODE;
  final String SCHUL_NM; //학교명
  // final int MMEAL_SC_CODE;
  final String MMEAL_SC_NM; //식사명 ex)중식
  final int MLSV_YMD; //급식일자
  // final int MLSV_FGR;
  final String DDISH_NM; //요리명
  final String ORPLC_INFO; //원산지정보
  final String CAL_INFO; //칼로리정보
  final String NTR_INFO; //영양정보
  // final int MLSV_FROM_YMD;

  MealModel.fromJson({required Map<String, dynamic> json})
      : SCHUL_NM = json['SCHUL_NM'],
        MMEAL_SC_NM = json['MMEAL_SC_NM'],
        MLSV_YMD = int.parse(json['MLSV_YMD']),
        DDISH_NM = json['DDISH_NM'],
        ORPLC_INFO = json['ORPLC_INFO'],
        CAL_INFO = json['CAL_INFO'],
        NTR_INFO = json['NTR_INFO'];
}

class schoolInfo {
  // 필요한 것들만 활성화 시켜 놓음 ex) 학교명, 요리명, 칼로리정보 등
  // final SchoolCode ATPT_OFCDC_SC_CODE;
  // final String ATPT_OFCDC_SC_NM;
  // final int SD_SCHUL_CODE;
  final String? SCHUL_NM; //학교명
  final String? SD_SCHUL_CODE; //학교 표준 코드
  final String? ATPT_OFCDC_SC_CODE; // 시도교육청 코드
  // final int MMEAL_SC_CODE;
  // final int MLSV_FGR;

  // final int MLSV_FROM_YMD;

  schoolInfo.fromJson({required Map<String, dynamic> json})
      : SCHUL_NM = json['SCHUL_NM'],
        ATPT_OFCDC_SC_CODE = json['ATPT_OFCDC_SC_CODE'],
        SD_SCHUL_CODE = json['SD_SCHUL_CODE'];
}
