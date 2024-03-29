import 'package:flutter/material.dart';

import '../../models/TableCellsElements.dart';

class GS_TableHeader extends StatelessWidget {
  const GS_TableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height / 26;

    return Table(
      border: TableBorder.all(color: Colors.green.shade100),
      columnWidths: <int, TableColumnWidth>{
        0: FixedColumnWidth(2 * MediaQuery.of(context).size.width / 8),
        1: FixedColumnWidth(3 * MediaQuery.of(context).size.width / 8),
        2: FixedColumnWidth(3 * MediaQuery.of(context).size.width / 8),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: <Widget>[
            HoursTableCell(height: _height),
            DayTableCell(height: _height, daysFromToday: 0),
            DayTableCell(
              height: _height,
              daysFromToday: 1,
            ),
          ],
        ),
      ],
    );
  }
}
