# png_chunks_encode

[![pub package](https://img.shields.io/pub/v/png_chunks_encode.svg)](https://pub.dev/packages/png_chunks_encode)

Dart port of [png-chunks-encode](https://github.com/hughsk/png-chunks-encode).

## Features

Return a fresh PNG buffer given a set of PNG chunks. Useful in combination with png-chunks-encode to
easily modify or add to the data of a PNG file.

By adding your own tEXt or zEXt chunks you have a useful alternative to LSB steganography for
making "magical" images with "secret" data available for your applications: the data is hardly
hidden this way, but you can store as much as you like. If you really wanted to, you could probably
get away with sneaking a 300MB 3D model in there without too much trouble 👻

## Getting started

In the pubspec.yaml of your flutter project, add the following dependency:

```yaml
dependencies:
...
png_chunks_encode: ^1.0.0
```

Import it:

```dart
import 'package:png_chunks_encode/png_chunks_encode.dart' as pngEncode;
```

## Usage

```dart
import 'package:png_chunks_encode/png_chunks_encode.dart' as pngEncode;

final buffer = pngEncode.encodeChunks(chunks);
```

Takes an array of chunks, each with a name and data:
```
[
{ name: 'IHDR', data: Uint8List([...]) },
{ name: 'IDAT', data: Uint8List([...]) },
{ name: 'IDAT', data: Uint8List([...]) },
{ name: 'IDAT', data: Uint8List([...]) },
{ name: 'IDAT', data: Uint8List([...]) },
{ name: 'IEND', data: Uint8List([]) }
]
```
And returns a Uint8List containing the raw PNG buffer.

## Example:

`test/png_chunks_encode_test.dart`