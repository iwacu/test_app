import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:momnotebook/constants/colors.dart';

class TimelinePainter extends CustomPainter {
  // final ui.Image img;

  // TimelinePainter(this.img);
  @override
  void paint(Canvas canvas, Size size) {
    drwaLines(canvas, size / 3);
  }

  void drwaLines(Canvas canvas, Size size) {
    var i = 1;
    final paint = Paint()
      ..color = Colors.black38
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    while (i <= 23) {
      canvas.drawLine(
        Offset(i * (size.width * 1 / 6), size.height * 1 / 2),
        Offset(i * (size.width * 1 / 6), size.height * 5 / 2),
        paint,
      );
      // drawImage(canvas, size, i);
      drawText(canvas, size, i);

      i++;
    }
  }

  void drawText(Canvas canvas, Size size, int i) {
    TextSpan span = new TextSpan(
        style: new TextStyle(color: Colors.blue[800]),
        text: i % 2 != 0 ? '' : i.toString());
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(
        canvas, new Offset(i * (size.width * 1 / 6), size.height * 5.2 / 2));
  }

  // void drawImage(Canvas canvas, Size size, int i) {
  //   if (i % 5 == 0) {
  //     // paintImage(img, rect, canvas, Paint(), BoxFit.cover);
  //     canvas.drawImage(
  //         img,
  //         new Offset(i * (size.width * 1.05 / 6), size.height * 1 / 2),
  //         Paint());
  //   }
  // }

  void paintImage(
      ui.Image image, Rect outputRect, Canvas canvas, Paint paint, BoxFit fit) {
    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());
    final FittedSizes sizes = applyBoxFit(fit, imageSize, outputRect.size);
    final Rect inputSubrect =
        Alignment.center.inscribe(sizes.source, Offset.zero & imageSize);
    final Rect outputSubrect =
        Alignment.center.inscribe(sizes.destination, outputRect);
    // canvas.drawImage(image, i * (size.width * 1 / 6), outputSubrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
