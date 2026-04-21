import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:base32/base32.dart';

String maskUSDTWalletAddress(String address) {
  if (address.length <= 6) return address;
  return '${address.substring(0, 4)} **** ${address.substring(address.length - 4)}';
}

String maskEmailAddress(String email) {
  if (email.isEmpty || !email.contains('@')) return email;

  final parts = email.split('@');
  if (parts.length != 2) return email;

  final username = parts[0];
  final domain = parts[1];

  final prefix = username.length >= 3 ? username.substring(0, 3) : username;
  return '$prefix****@$domain';
}

bool isEmailValid(String email) {
  if (email.isEmpty) return false;
  
  // 检查是否包含 @
  if (!email.contains('@')) return false;
  
  final parts = email.split('@');
  if (parts.length != 2) return false;
  
  final localPart = parts[0]; // 本地部分
  final domainPart = parts[1]; // 域名部分
  
  // 一、本地部分（@ 前）规则
  // 1. 长度：1-32 位
  if (localPart.isEmpty || localPart.length > 32) return false;
  
  // 2. 允许字符：a-z A-Z 0-9 . _ -
  final localPartRegex = RegExp(r'^[a-zA-Z0-9._-]+$');
  if (!localPartRegex.hasMatch(localPart)) return false;
  
  // 3. 不能以 . 开头或结尾
  if (localPart.startsWith('.') || localPart.endsWith('.')) return false;
  
  // 4. 不能连续出现 ..
  if (localPart.contains('..')) return false;
  
  // 二、域名部分（@ 后）规则
  // 1. 长度：1-63 位
  if (domainPart.isEmpty || domainPart.length > 63) return false;
  
  // 2. 必须包含 .
  if (!domainPart.contains('.')) return false;
  
  // 3. 不能以 . 或 - 开头/结尾
  if (domainPart.startsWith('.') || domainPart.endsWith('.') ||
      domainPart.startsWith('-') || domainPart.endsWith('-')) {
    return false;
  }
  
  // 4. 允许字符：a-z A-Z 0-9 . -
  final domainPartRegex = RegExp(r'^[a-zA-Z0-9.-]+$');
  if (!domainPartRegex.hasMatch(domainPart)) return false;
  
  // 5. 顶级域名长度：2-10 位
  final topLevelDomain = domainPart.split('.').last;
  if (topLevelDomain.length < 2 || topLevelDomain.length > 10) return false;
  
  return true;
}

/// 生成一个随机字节数组，并对其进行两次Base32编码。
String generateDoubleBase32EncodedString() {
  // 1. 生成35个加密安全的随机字节 (对应JS的前两行)
  // JS: const bytes = new Uint8Array(35)
  // JS: window.crypto.getRandomValues(bytes)
  final randomBytes = Uint8List(35);
  final secureRandom = Random.secure();
  for (var i = 0; i < randomBytes.length; i++) {
    randomBytes[i] = secureRandom.nextInt(256);
  }

  // 2. 进行第一次Base32编码 (对应JS的第三行)
  // JS: const base32Code = window.base32.encode(bytes)
  final firstBase32Encoding = base32.encode(randomBytes);

  // 3. 进行第二次Base32编码 (对应JS的第四行)
  // JS: const hiBase32Code = hiBase32.encode(base32Code)

  // 3a. 先将第一次编码生成的字符串，通过UTF-8转换为字节数组
  final bytesOfString = utf8.encode(firstBase32Encoding);

  // 3b. 然后对这个新的字节数组进行第二次Base32编码
  String secondBase32Encoding = base32.encode(bytesOfString);

  // --- 输出结果 ---
  print('Step 1: 原始随机字节 (预览):');
  print('${randomBytes.sublist(0, 5)}...\n');

  print('Step 2: 第一次 Base32 编码结果 (String):');
  print('$firstBase32Encoding\n');

  print('Step 3a: 将上面的字符串转为UTF-8字节 (预览):');
  print('${bytesOfString.sublist(0, 5)}...\n');

  print('Step 3b: 第二次 Base32 编码的最终结果 (String):');
  print(secondBase32Encoding);

  return secondBase32Encoding;
}

String trimEqualsSymbol(String input) {
  final trim = input.replaceAll('=', '');
  return trim;
}

String generateOtpAuthUrl(String secret) {
  return "otpauth://totp/sk?secret=$secret&algorithm=SHA1&digits=6&period=30&lock=false";
}

// void main() {
//   // 调用函数并打印结果
//   final result = generateDoubleBase32EncodedString();
//   print('\n最终生成的双重 Base32 编码字符串: $result');
//   final trimmedResult = trimEqualsSymbol(result);
//   print('移除等号后的结果: $trimmedResult');
//   final otpAuthUrl = generateOtpAuthUrl(trimmedResult);
//   print('OTP Auth URL: $otpAuthUrl');
// }
