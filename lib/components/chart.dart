import 'package:expenses/components/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  List<Transaction>? recentTransaction;

  List<Map<String, Object>> get groupedDays {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTransaction!.length; i++) {
        bool sameDay = recentTransaction![i].date!.day == weekDay.day;
        bool sameMonth = recentTransaction![i].date!.month == weekDay.month;
        bool sameYear = recentTransaction![i].date!.year == weekDay.year;
        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction![i].value!;
        }
      }
      print(DateFormat.E().format(weekDay)[0]);
      print(totalSum);
      return {
        "day": DateFormat.E().format(weekDay)[0],
        "value": totalSum,
      };
    }).reversed.toList();
  }

  Chart({this.recentTransaction});
  double get weekTotalValue {
    return groupedDays.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedDays;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          ...groupedDays.map((e) {
            return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  day: e['day'].toString(),
                  value: e['value'].toString(),
                  percentage: (e['value']! as double) / weekTotalValue,
                ),
            );
          }).toList()
        ]),
      ),
    );
  }
}
