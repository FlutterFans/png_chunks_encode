import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:png_chunks_encode/png_chunks_encode.dart';
import 'package:png_chunks_extract/png_chunks_extract.dart';

void main() {
  test('png-chunks-encode', () {
    var dir = Directory.current.path;
    if (dir.endsWith('/test')) {
      dir = dir.replaceAll('/test', '');
    }
    File file = File('$dir/test/test.png');
    final bytes = file.readAsBytesSync();

    final chunks = extractChunks(bytes);
    expect(bytes, encodeChunks(chunks));
  });
}