import 'dart:typed_data';

import 'etc32.dart';

var uint8 = Uint8List(4);
var int32 = Int32List.view(uint8.buffer);
var uint32 = Uint32List.view(uint8.buffer);

Uint8List encodeChunks(List<Map<String, dynamic>> chunks) {
  int totalSize = 8;
  int idx = totalSize;
  int i;

  for (i = 0; i < chunks.length; i++) {
    final chunk = chunks[i];
    totalSize += (chunk['data'] as List).length;
    totalSize += 12;
  }

  var output = new Uint8List(totalSize);

  output[0] = 0x89;
  output[1] = 0x50;
  output[2] = 0x4E;
  output[3] = 0x47;
  output[4] = 0x0D;
  output[5] = 0x0A;
  output[6] = 0x1A;
  output[7] = 0x0A;

  for (i = 0; i < chunks.length; i++) {
    var chunk = chunks[i];
    String name = chunk['name'];
    List<int> data = chunk['data'];
    var size = data.length;
    List<int> nameChars = [name.codeUnitAt(0), name.codeUnitAt(1), name.codeUnitAt(2), name.codeUnitAt(3)];

    uint32[0] = size;
    output[idx++] = uint8[3];
    output[idx++] = uint8[2];
    output[idx++] = uint8[1];
    output[idx++] = uint8[0];

    output[idx++] = nameChars[0];
    output[idx++] = nameChars[1];
    output[idx++] = nameChars[2];
    output[idx++] = nameChars[3];

    for (var j = 0; j < size;) {
      output[idx++] = data[j++];
    }

    List<int> crcCheck = List.from(nameChars)..addAll(data);
    var crc = Crc32.getCrc32(crcCheck);

    int32[0] = crc;
    output[idx++] = uint8[3];
    output[idx++] = uint8[2];
    output[idx++] = uint8[1];
    output[idx++] = uint8[0];
  }

  return output;
}
