import 'dart:io' as io;
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class ESRImageResizer {
  static Future<Uint8List?> resizeImageContain(
    String imagePath, {
    int targetWidth = 1200,
    int targetHeight = 630,
  }) async {
    try {
      final file = io.File(imagePath);
      final bytes = await file.readAsBytes();

      final originalImage = img.decodeImage(bytes);
      if (originalImage == null) return null;

      double imgRatio = originalImage.width / originalImage.height;
      double targetRatio = targetWidth / targetHeight;

      int drawWidth, drawHeight;
      int offsetX = 0;
      int offsetY = 0;

      if (imgRatio > targetRatio) {
        drawWidth = targetWidth;
        drawHeight = (targetWidth / imgRatio).round();
        offsetY = ((targetHeight - drawHeight) / 2).round();
      } else {
        drawHeight = targetHeight;
        drawWidth = (targetHeight * imgRatio).round();
        offsetX = ((targetWidth - drawWidth) / 2).round();
      }

      final resizedSubImage = img.copyResize(
        originalImage,
        width: drawWidth,
        height: drawHeight,
        interpolation: img.Interpolation.average,
      );

      final canvas = img.Image(
        width: targetWidth,
        height: targetHeight,
        numChannels: 4,
      );

      img.fill(canvas, color: img.ColorRgba8(0, 0, 0, 0));

      img.compositeImage(canvas, resizedSubImage, dstX: offsetX, dstY: offsetY);

      final webpBytes = img.encodeWebP(canvas);

      return Uint8List.fromList(webpBytes);
    } catch (e) {
      print("Error resizing image: $e");
      return null;
    }
  }
}
