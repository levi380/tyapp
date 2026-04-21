import 'package:filbet/utils/wallet_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isSimpleErc20Address', () {
    test('returns true for valid ERC20 address', () {
      expect(isSimpleErc20Address('0x1234567890123456789012345678901234567890'),
          isTrue);
    });

    test('returns false for null address', () {
      expect(isSimpleErc20Address(null), isFalse);
    });

    test('returns false for address without 0x prefix', () {
      expect(isSimpleErc20Address('1234567890123456789012345678901234567890'),
          isFalse);
    });

    test('returns false for address with incorrect length', () {
      expect(isSimpleErc20Address('0x1234'), isFalse);
      expect(
          isSimpleErc20Address('0x1234567890123456789012345678901234567890123'),
          isFalse);
    });
  });

  group('isSimpleTrc20Address', () {
    test('returns true for valid TRC20 address', () {
      expect(
          isSimpleTrc20Address('T123456789012345678901234567890123'), isTrue);
    });

    test('returns false for null address', () {
      expect(isSimpleTrc20Address(null), isFalse);
    });

    test('returns false for address without T prefix', () {
      expect(
          isSimpleTrc20Address('1234567890123456789012345678901234'), isFalse);
    });

    test('returns false for address with incorrect length', () {
      expect(isSimpleTrc20Address('T1234'), isFalse);
      expect(isSimpleTrc20Address('T12345678901234567890123456789012345'),
          isFalse);
    });
  });
}
