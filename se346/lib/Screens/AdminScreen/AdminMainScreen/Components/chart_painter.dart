import 'package:flutter/material.dart';

class ChartPainter extends CustomPainter{
  final List<String> x;
  final List<num> y;
  final num min,max;
  final Paint outlinePainter = Paint()
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke
    ..color = Colors.black;
  final Paint linePainter  =Paint()
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke
    ..color = Colors.black;
  final Paint dotPainter = Paint()
    ..strokeWidth = 2.0
    ..style = PaintingStyle.fill
    ..color = Colors.black12;
  final TextStyle labelStyle = TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold);
  final TextStyle labelStyle2 = TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold);
  List<Offset> chartPoints(Offset c,double width,double height,double hr){
    List<Offset> points = [];
    y.forEach((element) {
      final yy = height - (element - min) * hr;
      final dp = Offset(c.dx,c.dy -height / 2.0 + yy);
      points.add(dp);
      c+= Offset(width,0);
    });
    return points;
  }

  Path chartPaths(List<Offset> points){
    final path = Path();
    for (var i = 0; i < points.length;i++){
      final p = points[i];
      if (i==0){
        path.moveTo(p.dx, p.dy);
      }
      else {
        path.lineTo(p.dx, p.dy);
      }
    }
    return path;
  }
  ChartPainter (this.x,this.y,this.min,this.max);
  static double border = 10.0;
  @override
  void paint(Canvas canvas, Size size) {
    final clipRect = Rect.fromLTWH(0,25, size.width, size.height -40);
    canvas.clipRect(clipRect);
    canvas.drawPaint(Paint()..color = Colors.transparent);
    final drawableHeight = size.height - 2.0 * border;
    final drawableWidth = size.width - 2.0 * border;
    final hd = drawableHeight / 5.0;
    final height = hd * 3.0;
    final wd =  drawableWidth / this.x.length.toDouble();
    final width = drawableWidth;
    if (height <= 0.0 || width <= 0.0) return;
    if (max - min < 1.0e-6) return;
    final hr  =  height / (max - min);
    final left = border;
    final top = border;
    final c = Offset(left+wd/2,top+height/2 + 40);
    //DrawOutLine(canvas,c,wd,height);
    final points = chartPoints(c, wd, height, hr);
    final path = chartPaths(points);
    final labels = chartLabel();
    /*points.forEach((element) {
      canvas.drawCircle(element, 2.0, Paint()..color = Colors.black);
    });*/
    canvas.drawPath(path, linePainter);
    DrawDataPoints(points, canvas, c, wd, dotPainter);
    DrawDataLabels(canvas,labels,points,c,wd,top);
    var c1 = Offset(c.dx, top + 3.3 * hd + 40);
    DrawMonthLabels(canvas, x, c1, wd);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  void DrawOutLine(Canvas canvas, Offset c, double width, double height) {
    y.forEach((element) {
      final rect = Rect.fromCenter(center: c, width: width, height: height);
      canvas.drawRect(rect,outlinePainter);
      c+= Offset(width,0);
    });
  }

  List<String> chartLabel() {
    return y.map((e) => "${e.toString()}").toList();
  }
  TextPainter measureText(String s,TextStyle style,double maxWidth,TextAlign align){
    final span = TextSpan(text: s,style: style);
    final tp = TextPainter(
      text: span,textAlign: align,textDirection: TextDirection.ltr
    );
    tp.layout(maxWidth: maxWidth,minWidth: 0);

    return tp;
  }
  Size DrawTextCentered(Canvas canvas, Offset c, String text, TextStyle style, double maxWidth) {
    final tp = measureText(text,style,maxWidth,TextAlign.center);
    final offset = c+ Offset(-tp.width/2.0,-tp.height/2.0);
    tp.paint(canvas, offset);
    return tp.size;
  }
  void DrawDataPoints(List<Offset> points,Canvas canvas,Offset c, double wd, Paint dotPaintFill){
    for (var i = 0; i< points.length;i++){
      final dp = points[i];
      canvas.drawCircle(dp, 3.0, dotPainter);
      canvas.drawCircle(dp, 3.0, linePainter);
      c+= Offset(wd,0);
    }
  }

  void DrawDataLabels(Canvas canvas,List<String> labels, List<Offset> points,Offset c, double wd, double top){
    var i =0;
    labels.forEach((element) {
      var dp = points[i];
      var temp = dp.dy - 20.0 < top ? 20.0 : -20.0;
      var lp = dp + Offset(0, temp);
      DrawTextCentered(canvas,lp, element, labelStyle, wd);
      i++;
    });
  }

  void DrawMonthLabels(Canvas canvas,List<String> labels,Offset c, double wd){
    var i =0;
    labels.forEach((element) {
      DrawTextCentered(canvas,c, element, labelStyle2, wd);
      i++;
      c += Offset(wd,0);
    });
  }

}

