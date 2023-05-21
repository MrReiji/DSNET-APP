import 'package:flutter/material.dart';

import '../../models/TableCellsElements.dart';

class LS_TableHeader extends StatelessWidget {
  const LS_TableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height / 26;

    return Table(
      border: TableBorder.all(color: Colors.green.shade100),
      columnWidths: <int, TableColumnWidth>{
        0: FixedColumnWidth(2 * MediaQuery.of(context).size.width / 14),
        1: FixedColumnWidth(3 * MediaQuery.of(context).size.width / 14),
        2: FixedColumnWidth(3 * MediaQuery.of(context).size.width / 14),
        3: FixedColumnWidth(3 * MediaQuery.of(context).size.width / 14),
        4: FixedColumnWidth(3 * MediaQuery.of(context).size.width / 14),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: <Widget>[
            HoursTableCell(height: _height),
            DayTableCell(
              height: _height,
              daysFromToday: 0,
            ),
            DayTableCell(
              height: _height,
              daysFromToday: 1,
            ),
            DayTableCell(
              height: _height,
              daysFromToday: 2,
            ),
            DayTableCell(
              height: _height,
              daysFromToday: 3,
            ),
          ],
        ),
      ],
    );
  }
}
