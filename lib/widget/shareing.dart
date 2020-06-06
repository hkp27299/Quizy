import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_share_file/flutter_share_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

void convertWidgetToImage(String text, _containerKey) async {
  RenderRepaintBoundary renderRepaintBoundary =
      _containerKey.currentContext.findRenderObject();
  ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 1);
  ByteData byteData = await boxImage.toByteData(format: ui.ImageByteFormat.png);
  Uint8List uInt8List = byteData.buffer.asUint8List();
  final tempDir = await getTemporaryDirectory();
  final file = await new File('${tempDir.path}/image.jpg').create();
  file.writeAsBytesSync(uInt8List);
  File testFile = new File("${tempDir.path}/image.jpg");
  print(testFile);
  FlutterShareFile.shareImage(tempDir.path, "image.jpg", text);
}
