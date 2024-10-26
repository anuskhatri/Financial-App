import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:d_chart/numeric/line.dart';
import 'package:flutter/material.dart';

class StockLineChart extends StatelessWidget {
  final List<TimeData> timeDataList;

  StockLineChart({super.key, required this.timeDataList});

  @override
  Widget build(BuildContext context) {
    final List<TimeGroup> timeGroupList = [
      TimeGroup(
        id: '1',
        data: timeDataList,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0), // Adds padding for better alignment
      child: AspectRatio(
        aspectRatio: 1.3,
        child: DChartLineN(
            groupList: timeGroupList
                .map((timeGroup) => NumericGroup(
                      id: timeGroup.id,
                      data: timeGroup.data
                          .map((timeData) => NumericData(
                                domain: timeData.domain.month,
                                measure: timeData.measure,
                              ))
                          .toList(),
                    ))
                .toList()),
      ),
    );
  }
}
