import 'package:flutter/material.dart';

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
            TableCell(
              child: Container(
                height: _height,
                color: Colors.green.shade100,
                child: const Center(
                  child: Text(
                    "Godzina",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                height: _height,
                color: Colors.green.shade100,
                child: Center(
                  child: Text(
                    DateTime.now().toString().substring(0, 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                height: _height,
                color: Colors.green.shade100,
                child: Center(
                  child: Text(
                    DateTime(DateTime.now().year, DateTime.now().month,
                            DateTime.now().day + 1)
                        .toString()
                        .substring(0, 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
