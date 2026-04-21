import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class ValidationRule {
  final String text;
  final bool isValid;

  ValidationRule({required this.text, required this.isValid});
}

bool mustOnlyContainAlphanumeric(String value) {
  return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);
}

/// 以字母开头
bool mustOnlyContainAlphanumeric01(String value) {
  return RegExp(r'^(?=(?:.*[A-Za-z]){2,})(?=.*\d)[A-Za-z][A-Za-z0-9]{3,10}$')
      .hasMatch(value);
}

bool mustOnlyNumber(String value) {
  return RegExp(r'^[0-9]+$').hasMatch(value);
}

bool mustContainNumber(String value) {
  return RegExp(r'[0-9]').hasMatch(value);
}

bool mustContainAtLeastOneUpperCase(String value) {
  return RegExp(r'[A-Z]').hasMatch(value);
}

bool mustContainAtLeastOneLowerCase(String value) {
  return RegExp(r'[a-z]').hasMatch(value);
}

bool isLetterNumber(String value) {
  return RegExp(
    r'^[a-z]+$',
    caseSensitive: false,
  ).hasMatch(value);
}

bool mustContainAtLeastOneUpperCaseAndOneLowerCase(String value) {
  return mustContainAtLeastOneUpperCase(value) &&
      mustContainAtLeastOneLowerCase(value);
}

bool mustContainAtLeastOneUpperCaseOrOneLowerCase(String value) {
  return mustContainAtLeastOneUpperCase(value) ||
      mustContainAtLeastOneLowerCase(value);
}

/// 至少一个非字母、非数字字符（与密码输入允许的 ASCII 可打印范围一致）。
bool mustContainAtSpecial(String value) {
  return RegExp(r'[^A-Za-z0-9]').hasMatch(value);
}

enum CredentialStringValidateType {
  isRange4to11,
  containAlphanumeric,
  inRange8to12,
  containsUpperAndLowerCase,
  containsUpperOrLowerCase,
  containsNumber,
  onlyNumber,
  length6,
  numbersLetters, //数字 + 字母
  containsNumOrSpecial, //数字 或 特殊字符
  containsLetterAndSpecial; //字母 + 特殊字符

  bool validate(String value) {
    switch (this) {
      case CredentialStringValidateType.isRange4to11:
        return value.length >= 4 && value.length <= 11;
      case CredentialStringValidateType.containAlphanumeric:
        return mustOnlyContainAlphanumeric01(value);
      case CredentialStringValidateType.inRange8to12:
        return value.length >= 8 && value.length <= 12;
      case CredentialStringValidateType.containsUpperAndLowerCase:
        return mustContainAtLeastOneUpperCaseAndOneLowerCase(value);
      case CredentialStringValidateType.containsUpperOrLowerCase:
        return mustContainAtLeastOneUpperCaseOrOneLowerCase(value);
      case CredentialStringValidateType.containsNumber:
        return mustContainNumber(value);
      case CredentialStringValidateType.onlyNumber:
        return mustOnlyNumber(value);
      case CredentialStringValidateType.length6:
        return value.length == 6;
      case CredentialStringValidateType.containsNumOrSpecial:
        return mustContainNumber(value) || mustContainAtSpecial(value);
      case CredentialStringValidateType.numbersLetters:
        return isLetterNumber(value);
      case CredentialStringValidateType.containsLetterAndSpecial:
        return mustOnlyNumber(value) && mustContainAtSpecial(value);
    }
  }

  String get description {
    switch (this) {
      case CredentialStringValidateType.isRange4to11:
        return 'char_4_11_letter_digit'.tr;
      case CredentialStringValidateType.containAlphanumeric:
        return 'only_letters_and_digits'.tr;
      case CredentialStringValidateType.inRange8to12:
        return 'char_8_12'.tr;
      case CredentialStringValidateType.containsUpperAndLowerCase:
        return 'must_include_upper_lower'.tr;
      case CredentialStringValidateType.containsUpperOrLowerCase:
        return 'must_include_letter'.tr;
      case CredentialStringValidateType.containsNumber:
        return 'must_include_digit'.tr;
      case CredentialStringValidateType.onlyNumber:
        return 'only_digits'.tr;
      case CredentialStringValidateType.length6:
        return 'char_6_digit'.tr;
      case CredentialStringValidateType.containsNumOrSpecial:
        return 'login_pwd_rule'.tr;
      case CredentialStringValidateType.numbersLetters:
        return 'login_pwd_rule'.tr;
      case CredentialStringValidateType.containsLetterAndSpecial:
        return 'login_pwd_rule'.tr;
    }
  }
}

List<Tuple2<CredentialStringValidateType, bool>> accountStringValidate(
    String value) {
  return [
    Tuple2(
      CredentialStringValidateType.isRange4to11,
      value.length >= 4 && value.length <= 11,
    ),
    Tuple2(
      CredentialStringValidateType.containAlphanumeric,
      CredentialStringValidateType.containAlphanumeric.validate(value),
    ),
  ];
}

List<Tuple2<CredentialStringValidateType, bool>> passwordStringValidate(
    String value) {
  return [
    Tuple2(
      CredentialStringValidateType.inRange8to12,
      value.length >= 8 && value.length <= 12,
    ),
    Tuple2(
      CredentialStringValidateType.containsUpperAndLowerCase,
      CredentialStringValidateType.containsUpperAndLowerCase.validate(value),
    ),
    Tuple2(
      CredentialStringValidateType.containsNumber,
      CredentialStringValidateType.containsNumber.validate(value),
    ),
  ];
}

// 8~20位
// 大小写+数字
// 大小写+特殊字符
// 大小写+数字+特殊字符
List<Tuple2<CredentialStringValidateType, bool>> passwordStringValidate02(
    String value) {
  return [
    Tuple2(
      CredentialStringValidateType.inRange8to12,
      value.length >= 8 && value.length <= 20,
    ),
    Tuple2(
      CredentialStringValidateType.containsUpperAndLowerCase,
      CredentialStringValidateType.containsUpperAndLowerCase.validate(value),
    ),
    Tuple2(
      CredentialStringValidateType.containsNumOrSpecial,
      CredentialStringValidateType.containsNumOrSpecial.validate(value),
    ),
  ];
}

// 密码：可输入可打印 ASCII（见 AppUtils.getInputFormatters）；
// 「含数字或符号」中符号指任一非 A–Z / a–z / 0–9 字符（mustContainAtSpecial）。
List<Tuple2<CredentialStringValidateType, bool>> passwordStringValidate03(
    String value) {
  return [
    Tuple2(
      CredentialStringValidateType.inRange8to12,
      value.length >= 8 && value.length <= 12,
    ),
    Tuple2(
      CredentialStringValidateType.containsUpperOrLowerCase,
      CredentialStringValidateType.containsUpperOrLowerCase.validate(value),
    ),
    Tuple2(
      CredentialStringValidateType.containsNumOrSpecial,
      CredentialStringValidateType.containsNumOrSpecial.validate(value),
    ),
  ];
}

List<Tuple2<CredentialStringValidateType, bool>> paymentPasswordStringValidate(
    String value) {
  return [
    Tuple2(
      CredentialStringValidateType.length6,
      value.length == 6,
    ),
    Tuple2(
      CredentialStringValidateType.onlyNumber,
      CredentialStringValidateType.onlyNumber.validate(value),
    ),
  ];
}

List<ValidationRule> convertCredentialValidateResultToValidationRules(
  List<Tuple2<CredentialStringValidateType, bool>> results,
) {
  return results
      .map((result) => ValidationRule(
            text: result.item1.description,
            isValid: result.item2,
          ))
      .toList();
}
