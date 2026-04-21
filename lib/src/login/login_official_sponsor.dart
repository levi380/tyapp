class LoginOfficialSponsor {
  const LoginOfficialSponsor({
    required this.asset,
    required this.titleKey,
  });

  final String asset;
  /// GetX 翻译 key，展示时使用 `titleKey.tr`
  final String titleKey;
}
