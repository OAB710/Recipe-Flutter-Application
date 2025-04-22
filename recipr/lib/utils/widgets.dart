import 'dart:math';
import 'package:flutter/material.dart';
import 'package:recipr/utils/class.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CircleIndicator extends StatefulWidget {
  final double percent;
  final Nutrients nutrient;

  CircleIndicator({this.percent = 0.5, required this.nutrient});

  @override
  _CircleIndicatorState createState() => _CircleIndicatorState();
}

class _CircleIndicatorState extends State<CircleIndicator>
    with SingleTickerProviderStateMixin {
  double fraction = 0.0;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    var controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    animation = Tween(begin: 0.0, end: widget.percent).animate(controller)
      ..addListener(() {
        setState(() {
          fraction = animation.value;
        });
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    String nutrientName = widget.nutrient.name.toLowerCase();
    String localizedNutrientName;
    switch (nutrientName) {
      case 'calories':
        localizedNutrientName = localizations!.calories_label;
        break;
      case 'protein':
        localizedNutrientName = localizations!.protein_label;
        break;
      case 'carb':
        localizedNutrientName = localizations!.carb_label;
        break;
      case 'fat':
        localizedNutrientName = localizations!.fat_label;
        break;
      default:
        localizedNutrientName = widget.nutrient.name;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: 75,
            height: 75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  localizedNutrientName,
                  style: TextStyle(
                    color: Color(0xFF212121), // Text đậm
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.nutrient.weight,
                  style: TextStyle(color: Color(0xFF212121)),
                ),
              ],
            ),
          ),
          Container(
            width: 75,
            height: 75,
            child: CustomPaint(foregroundPainter: CirclePainter(fraction)),
          ),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  late Paint _paint;
  double _fraction;

  CirclePainter(this._fraction) {
    _paint =
        Paint()
          ..color = Color(0xFFFF9750) // Cam đậm nổi bật
          ..strokeWidth = 5.0
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset(0.0, 0.0) & size;
    canvas.drawArc(rect, -pi / 2, pi * 2 * _fraction, false, _paint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate._fraction != _fraction;
  }
}
