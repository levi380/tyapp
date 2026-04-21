import 'dart:math';
import 'dart:typed_data';
 

class Endian {
  /// 表示多字节数字的最低有效字节位于字节序列的最前面。
  /// 十六进制数字 0x12345678 包含 4 个字节（每个字节包含 2 个十六进制数字）。最高有效字节为 0x12。最低有效字节为 0x78。（对于等效的十进制数字 305419896，最高有效数字是 3，最低有效数字是 6）。
  /// @version Egret 2.4
  /// @platform Web,Native
  /// @language zh_CN
  static const LITTLE_ENDIAN = "littleEndian";
  /// 表示多字节数字的最高有效字节位于字节序列的最前面。
  /// 十六进制数字 0x12345678 包含 4 个字节（每个字节包含 2 个十六进制数字）。最高有效字节为 0x12。最低有效字节为 0x78。（对于等效的十进制数字 305419896，最高有效数字是 3，最低有效数字是 6）。
  /// @version Egret 2.4
  /// @platform Web,Native
  /// @language zh_CN
  static const BIG_ENDIAN = "bigEndian";
}

class EndianConst {
  static const LITTLE_ENDIAN = 0;
  static const BIG_ENDIAN = 1;
}

class ByteArray {
  /// @private
  var bufferExtSize = 0; //Buffer expansion size

  var data;

  var _bytes;
  /// @private
  var _position;

  ///
  /// 已经使用的字节偏移量
  /// @protected
  /// @type {number}
  /// @memberOf ByteArray
  var write_position;

  /// 更改或读取数据的字节顺序；egret.EndianConst.BIG_ENDIAN 或 egret.EndianConst.LITTLE_ENDIAN。
  /// @default egret.EndianConst.BIG_ENDIAN
  /// @version Egret 2.4
  /// @platform Web,Native
  /// @language zh_CN
  get endian {
    return $endian == EndianConst.LITTLE_ENDIAN ? Endian.LITTLE_ENDIAN : Endian.BIG_ENDIAN;
  }

  set endian(value) {
    $endian = value == Endian.LITTLE_ENDIAN ? EndianConst.LITTLE_ENDIAN : EndianConst.BIG_ENDIAN;
  }

  var $endian;

  /// @version Egret 2.4
  /// @platform Web,Native
  ByteArray(Uint8List buffer, {this.bufferExtSize = 0}) {
    if (bufferExtSize < 0) {
      bufferExtSize = 0;
    }
    int wpos = 0;
    Uint8List uint8;
    uint8 = buffer;
    wpos = buffer.length;
      Uint8List bytes;
    if (bufferExtSize == 0) {
      bytes = Uint8List(wpos);
    } else {
      int multi = (wpos / bufferExtSize).ceil() + 1;
      bytes = Uint8List(multi * bufferExtSize);
    }
    bytes.setRange(0, wpos, uint8);
    data = bytes;
      write_position = wpos;
    _position = 0;
    _bytes = data;
    // You can set the endian property here if needed
    endian = Endian.BIG_ENDIAN;
  }

  /// @deprecated
  /// @version Egret 2.4
  /// @platform Web,Native
  setArrayBuffer(buffer) {}

  /// 可读的剩余字节数
  ///
  /// @returns
  ///
  /// @memberOf ByteArray
  get readAvailable {
    return write_position - _position;
  }


  get rawBuffer {
    return data.buffer;
  }


  set buffer(Uint8List value) {
    int wpos = value.length;
    Uint8List uint8 = Uint8List.fromList(value);
    Uint8List bytes;

    if (bufferExtSize == 0) {
      bytes = Uint8List(wpos);
    } else {
      int multi = (wpos / bufferExtSize).ceil() + 1;
      bytes = Uint8List(multi * bufferExtSize);
    }

    bytes.setAll(0, uint8);
    write_position = wpos;
    _bytes = bytes;
    data = ByteData.sublistView(bytes);
  }

  Uint8List get bytes {
    return _bytes;
  }

  /// @private
  /// @version Egret 2.4
  /// @platform Web,Native
  get dataView {
    return data;
  }

  /// @private
  set dataView(value) {
    buffer = value.buffer;
  }

  /// @private
  get bufferOffset {
    return data.byteOffset;
  }

  /// 将文件指针的当前位置（以字节为单位）移动或返回到 ByteArray 对象中。下一次调用读取方法时将在此位置开始读取，或者下一次调用写入方法时将在此位置开始写入。
  /// @version Egret 2.4
  /// @platform Web,Native
  /// @language zh_CN
  get position {
    return _position;
  }

  set position(value) {
    _position = value;
    if (value > write_position) {
      write_position = value;
    }
  }

  /**
   * The length of the ByteArray object (in bytes).
               * If the length is set to be larger than the current length, the right-side zero padding byte array.
               * If the length is set smaller than the current length, the byte array is truncated.
   * @version Egret 2.4
   * @platform Web,Native
   * @language en_US
   */
  /// ByteArray 对象的长度（以字节为单位）。
  /// 如果将长度设置为大于当前长度的值，则用零填充字节数组的右侧。
  /// 如果将长度设置为小于当前长度的值，将会截断该字节数组。
  /// @version Egret 2.4
  /// @platform Web,Native
  /// @language zh_CN


  int get length {
    return write_position;
  }

  set length(int value) {
    write_position = value;
    if (_bytes.lengthInBytes > value) {
      _position = value;
    }
    _validateBuffer(value);
  }



  void _validateBuffer(int value) {
    if (_bytes.lengthInBytes < value) {
      int be = bufferExtSize;
      Uint8List tmp;

      if (be == 0) {
        tmp = Uint8List(value);
      } else {
        int nLen = ((value / be).ceil() + 1) * be;
        tmp = Uint8List(nLen);
      }

      tmp.setAll(0, _bytes);
      _bytes = tmp;
      data = ByteData.sublistView(tmp);
    }
  }

  /**
   * The number of bytes that can be read from the current position of the byte array to the end of the array data.
   * When you access a ByteArray object, the bytesAvailable property in conjunction with the read methods each use to make sure you are reading valid data.
   * @version Egret 2.4
   * @platform Web,Native
   * @language en_US
   */
  /// 可从字节数组的当前位置到数组末尾读取的数据的字节数。
  /// 每次访问 ByteArray 对象时，将 bytesAvailable 属性与读取方法结合使用，以确保读取有效的数据。
  /// @version Egret 2.4
  /// @platform Web,Native
  /// @language zh_CN
  get bytesAvailable {
    return data.length - _position;
  }

  /**
   * Clears the contents of the byte array and resets the length and position properties to 0.
   * @version Egret 2.4
   * @platform Web,Native
   * @language en_US
   */
  /// 清除字节数组的内容，并将 length 和 position 属性重置为 0。
  /// @version Egret 2.4
  /// @platform Web,Native
  /// @language zh_CN

  void clear() {
    var buffer = Uint8List(bufferExtSize).buffer;
    // data = ByteData.sublistView(buffer);//TODO
    _bytes = Uint8List.view(buffer);
    _position = 0;
    write_position = 0;
  }
  
  writeBytes(bytes, {offset = 0, length = 0}) {
    int writeLength;
    if (offset < 0) {
      return;
    }
    if (length < 0) {
      return;
    } else if (length == 0) {
      writeLength = bytes.length - offset;
    } else {
      writeLength = min(bytes.length - offset, length);
    }
    if (writeLength > 0) {
      validateBuffer(writeLength);
      _bytes.set(bytes._bytes.subarray(offset, offset + writeLength), _position);
      position = _position + writeLength;
    }
  }

  ///
  /// @returns
  /// @version Egret 2.4
  /// @platform Web,Native
  toString() {
    return "[ByteArray] length:$length, bytesAvailable:$bytesAvailable" ;
  }

  /**********************/
  /*  PRIVATE METHODS   */
  /**********************/
  /// @private
  /// @param len :number
  /// @param needReplace
  /// @returns void
  validateBuffer(len) {
    write_position = len > write_position ? len : write_position;
    len += _position;
    _validateBuffer(len);
  }

  /// @private
  ///
  /// @param a
  /// @param min
  /// @param max
  inRange(a, min, max) {
    return min <= a && a <= max;
  }

}

/// 解路纸工具
/// @param { string } base64String // 服务器返回的路纸数据字符串
class RoadUtils {
  String _bitString = '';
/// number
  int _pointer = 0;
/// number
  int _length = 0;
  RoadUtils(base64String) {
    initLookUp();
    var buf = base64UtilDecode(base64String);
    _bitString = getBits(buf);
    _length = _bitString.length;

  }

  get length {
    return _length;
  }

/// 获取当前ArrayBuffer的二进制字符串
/// buf:ArrayBuffer
/// return: string;
  String getBits(Uint8List buffer) {
    ByteArray bytesArray = ByteArray(buffer);
    int length = bytesArray.bytesAvailable;
    String binaryString = '';

    for (var i = 0; i < length; i++) {
      final item = buffer[i];
      final bitsStr = item.toRadixString(2);
      binaryString += '0' * (8 - bitsStr.length);
      binaryString += bitsStr;
    }
    return binaryString;
  }

/// 补0
/// count：number
/// return string;
  coverZero(count) {
    var tempStr = '';
    for (int i = 0; i < count; i++) {
      tempStr += '0';
    }
    return tempStr;
  }

/// 获取制定长度的bit并转换成数值
/// size:number
/// return: number
  getNextInteger(int size) {
    String sub = _bitString.substring(_pointer, _pointer + size);
    int result = int.parse(sub, radix: 2);
    _pointer += size;
    return result;
  }

  /// @private
  var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
  /// @private

  Uint8List lookup = Uint8List(256);
  initLookUp() {
    for (int i = 0; i < chars.length; i++) {
      lookup[chars.codeUnitAt(i)] = i;
    }
  }

  /// @language zh_CN
  /// 解码base64。
  /// @version Egret 2.4
  /// @platform Web,Native

  Uint8List base64UtilDecode(String base64) {
    var bufferLength = (base64.length * 0.75).toInt();
    final len = base64.length;
    var p = 0;
    var encoded1 = 0;
    var encoded2 = 0;
    var encoded3 = 0;
    var encoded4 = 0;

    if (base64[base64.length - 1] == '=') {
      bufferLength--;
      if (base64[base64.length - 2] == '=') {
        bufferLength--;
      }
    }

    final arrayBuffer = Uint8List(bufferLength).buffer;
    final bytes = Uint8List.view(arrayBuffer);
    for (var i = 0; i < len; i += 4) {
      encoded1 = lookup[base64.codeUnitAt(i)];
      encoded2 = lookup[base64.codeUnitAt(i + 1)];

      if (base64[i + 2] != '=') {
        encoded3 = lookup[base64.codeUnitAt(i + 2)];
        if (base64[i + 3] != '=') {
          encoded4 = lookup[base64.codeUnitAt(i + 3)];
        } else {
          encoded4 = 0; // Set to zero if padding
        }
      } else {
        encoded3 = encoded4 = 0; // Set to zero if padding
      }

      bytes[p++] = (encoded1 << 2) | (encoded2 >> 4);

      if (base64[i + 2] != '=') {
        bytes[p++] = ((encoded2 & 15) << 4) | (encoded3 >> 2);
        if (base64[i + 3] != '=') {
          bytes[p++] = ((encoded3 & 3) << 6) | (encoded4 & 63);
        }
      }
    }

    return bytes;
  }

  /// @language zh_CN
  /// 编码base64。
  /// @platform Web,Native
  String base64UtilEncode(Uint8List arrayBuffer) {
    final bytes = Uint8List.fromList(arrayBuffer);
    final len = bytes.length;
    var base64 = '';

    for (var i = 0; i < len; i += 3) {
      base64 += chars[bytes[i] >> 2];
      base64 += chars[((bytes[i] & 3) << 4) | (bytes[i + 1] >> 4)];
      base64 += chars[((bytes[i + 1] & 15) << 2) | (bytes[i + 2] >> 6)];
      base64 += chars[bytes[i + 2] & 63];
    }

    if (len % 3 == 2) {
      base64 = '${base64.substring(0, base64.length - 1)}=';
    } else if (len % 3 == 1) {
      base64 = '${base64.substring(0, base64.length - 2)}==';
    }

    return base64;
  }
}
