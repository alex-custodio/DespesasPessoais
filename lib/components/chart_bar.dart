import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  String? day;
  String? value;
  double? percentage;

  ChartBar({this.day, this.value, this.percentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 20, child: FittedBox(child: Text("R\$${value}"))),
        SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey,
                ),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(5)
              ),
            ),
            FractionallySizedBox(
              heightFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(5)
                ),
              ),

            )
          ],),
        ),
        SizedBox(height: 5),
        Text("${day}")
      ],
    );
  }
}
