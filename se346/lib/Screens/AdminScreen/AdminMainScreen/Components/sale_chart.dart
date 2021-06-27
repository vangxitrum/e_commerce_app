import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/AdminMainScreen/Components/chart_painter.dart';

class SaleChart extends StatefulWidget {
  final List<Sale> saleData;
  SaleChart({
    Key? key,
    required this.saleData,
  }) : super(key: key);

  @override
  _SaleChartState createState() => _SaleChartState();
}

class _SaleChartState extends State<SaleChart> {
  late int _min,_max;
  late List<int> _y;
  final List<String> _x = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Agu","Sep","Oct","Nov","Dec"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var max = 0, min = 0;
    widget.saleData.forEach((element) {
      min = min > element.amount ? element.amount : min;
      max = max < element.amount ? element.amount : max;
    });
    setState(() {
      _min = min;
      _max = max;
      _y = widget.saleData.map((p) => p.amount).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:CustomPaint(
        child: Container(),
        painter: ChartPainter(_x,_y,_min,_max),
      )
    );
  }
}
//

class Sale{
  late int amount;
  late int month;
  Sale(this.amount,this.month);
}