

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';
import 'package:urine/common/dart/extension/datetime_extension.dart';
import 'package:urine/layers/domain/usecase/auth_usecase.dart';
import 'package:urine/main.dart';

import '../../../../common/data/validate/singup_validate.dart';
import '../../../../common/util/snackbar_utils.dart';
import '../../../entity/signup_dto.dart';
import '../../widget/bottomsheet/datepicker_bottom_sheet.dart';
import '../../widget/w_custom_dialog.dart';
import 'd_terms_dialog.dart';

class SignupViewModel extends ChangeNotifier {

  /// 아이디 TextEditing
  final _idController = TextEditingController();

  /// 패스워드 TextEditing
  final _passController = TextEditingController();

  /// 패스워드 재입력 TextEditing
  final _pass2Controller = TextEditingController();

  /// 닉네임 TextEditing
  final _nickNameController = TextEditingController();

  /// 생년월일 picker string
  String? _birthdate;

  /// 성별 dropdown string
  String? _gender;

  /// 개인정보 약관 accpet
  bool _isCheckedInfo = false;

  /// 서비스 이용 약관 accpet
  bool _isCheckedService = false;

  /// 이용약관 모두 동의가 되어있는지? true: 회원가입 버튼 생성
  bool _isAllChecked = false;

  TextEditingController get idController => _idController;
  TextEditingController get passController => _passController;
  TextEditingController get pass2Controller => _pass2Controller;
  TextEditingController get nickNameController => _nickNameController;
  String? get gender => _gender;
  String? get birthdate => _birthdate;
  bool get isCheckedInfo => _isCheckedInfo;
  bool get isCheckedService => _isCheckedService;
  bool get isAllChecked => _isAllChecked;

  set gender(String? value) {
    _gender = value;
    notifyListeners();
  }

  set isCheckedInfo(bool? value) {
    _isCheckedInfo = value ?? false;
    _isAllChecked = _isCheckedInfo && _isCheckedService;
    notifyListeners();
  }

  set isCheckedService(bool? value) {
    _isCheckedService = value ?? false;
    _isAllChecked = _isCheckedInfo && _isCheckedService;
    notifyListeners();
  }

  /// 회원가입
  Future<void> signup(BuildContext context) async {
    if (validationSignup(context)) {
      return;
    }

    try {
      SignupUseCase().execute(toMap()).then((response) {
        if (response?.status.code == '200' && response != null) {
          Nav.doPop(context); // 회원가입 화면 pop
          SnackBarUtils.showPrimarySnackBar(context, '회원가입이 완료 되었습니다.');
        } else if (response!.status.code == 'ERR_EVS_8013') {
          signDialog(context, '중복된 아이디입니다.\n다시 입력해주세요.');
        } else {
          signDialog(context, '회원가입이 정상적으로 처리되지 않았습니다.');
        }
      });
    } on DioException catch (e) {
      logger.e(e);
      signDialog(context, '죄송합니다.\n예기치 않은 문제가 발생했습니다.');
    } catch (e) {
      logger.e(e);
      signDialog(context, '죄송합니다.\n예기치 않은 문제가 발생했습니다.');
    }
  }


  /// 회원가입 유효성 체크
  bool validationSignup(BuildContext context){
    if(
      SignValidate.checkID(_idController.text, context)&&
      SignValidate.checkPassword(_passController.text, context)&&
      SignValidate.checkPassword2(_pass2Controller.text, context)&&
      SignValidate.checkSamePassword(_passController.text, _pass2Controller.text, context)&&
      SignValidate.checkNickName(_nickNameController.text, context)&&
      // SignValidate.checkDateOfBirth(_birthdate, context)&&
      // SignValidate.checkGender(_gender, context)&&
      SignValidate.checkTerms(!(_isCheckedInfo&isCheckedService), context)){

      return false; // 위 체크 내용이 true 경우
    }
    else {
      return true; // 위 체크 내용이 false 경우}
    }
  }


  Map<String, dynamic> toMap() {
    return {
      'userID'   : _idController.text,
      'password' : _passController.text,
      'name'     : _nickNameController.text,
    };
  }


  /// 생년월일 날짜 피커 보기
  showDataPickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return DatePickerBottomSheet(
          onSubmit: (date) {
            _birthdate = date.formattedDate;
            notifyListeners();
          },
        );
      },
    );
  }


  /// 회원가입 다이얼로그
  signDialog(BuildContext context, String message){
    CustomDialog.showMyDialog(
      title: '회원가입',
      content: message,
      mainContext: context,
    );
  }


  /// 이용약관 다이얼로그
  showTermsDialog(BuildContext context) {
   return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return TermsAlertDialog();
      },
    );
  }
}