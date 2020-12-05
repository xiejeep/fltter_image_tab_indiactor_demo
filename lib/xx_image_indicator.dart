import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

/*自定义tabbar指示器
distanceFromCenter 距离文字距离
image  NativeFieldWrapperClass2图片,需要import 'dart:ui' as ui;
*/
class XXImageIndicator extends Decoration {

  /// Distance from the center, if you the value is positive, the dot will be positioned below the tab's center
  /// if the value is negative, then dot will be positioned above the tab's center, default set to 8
  final double distanceFromCenter;

  final ui.Image image;
  final Size imageSize;

  XXImageIndicator({
    this.distanceFromCenter = 8,
    @required this.image,
    this.imageSize = const Size(15, 8),
  });
  @override
  _CustomPainter createBoxPainter([VoidCallback onChanged]) {
    return new _CustomPainter(
        this, onChanged, distanceFromCenter, image, imageSize);
  }

  /// 加载指示器图片
  static Future<ui.Image> loadImage(String path) async {
    var data = await rootBundle.load(path);
    var codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    var info = await codec.getNextFrame();
    return info.image;
  }
}

class _CustomPainter extends BoxPainter {
  final XXImageIndicator decoration;
  final double distanceFromCenter;
  final ui.Image image;
  final Size imageSize;

  _CustomPainter(
    this.decoration,
    VoidCallback onChanged,
    this.distanceFromCenter,
    this.image,
    this.imageSize,
  )   : assert(
          decoration != null,
        ),
        super(onChanged);
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    final Paint paint = Paint();
    double xAxisPos = offset.dx + configuration.size.width / 2;
    double yAxisPos =
        offset.dy + configuration.size.height / 2 + distanceFromCenter;
    Rect rect = Rect.fromCenter(
        center: Offset(xAxisPos, yAxisPos),
        width: imageSize.width,
        height: imageSize.height);
    // canvas.drawImage(image, Offset(xAxisPos, yAxisPos), paint);
    canvas.drawImageNine(image, rect, rect, paint);
  }
}
