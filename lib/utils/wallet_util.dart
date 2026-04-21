/// 简单校验 ERC20 地址格式（仅检查前缀和长度）。
///
/// [address] 要校验的地址字符串。
/// [return] 如果地址以 "0x" 开头且长度为42，则返回 `true`，否则返回 `false`。
bool isSimpleErc20Address(String? address) {
  if (address == null) {
    return false;
  }

  bool startsWith0x = address.startsWith('0x');
  bool hasCorrectLength = address.length == 42;

  return startsWith0x && hasCorrectLength;
}

/// 简单校验 TRC20 地址格式（仅检查前缀和长度）。
///
/// [address] 要校验的地址字符串。
/// [return] 如果地址以 "T" 开头且长度为34，则返回 `true`，否则返回 `false`。
bool isSimpleTrc20Address(String? address) {
  if (address == null) {
    return false;
  }

  bool startsWithT = address.startsWith('T');
  bool hasCorrectLength = address.length == 34;

  return startsWithT && hasCorrectLength;
}

bool isSimpleEbPayAddress(String? address) {
  if (address == null) {
    return false;
  }
  // 大小写忽略
  // final ebAddressRegex = RegExp(r'^eb[a-zA-Z0-9]{32}$', caseSensitive: false);
  final ebAddressRegex = RegExp(r'^eb[a-zA-Z0-9]{32}$');
  return ebAddressRegex.hasMatch(address);
}

bool isSimpleHdPayAddress(String? address) {
  if (address == null) {
    return false;
  }
  // 大小写忽略
  // final hdAddressRegex = RegExp(r'^HD[a-zA-Z0-9]{17}$', caseSensitive: false);
  final hdAddressRegex = RegExp(r'^HD[a-zA-Z0-9]{21}$');
  return hdAddressRegex.hasMatch(address);
}

bool isSimpleNoPayAddress(String? address) {
  if (address == null) {
    return false;
  }
  final reg = RegExp(r'^.{6,16}$');
  return reg.hasMatch(address);
}

bool isSimplePayAddress(String? address) {
  return address?.isNotEmpty == true;
}
