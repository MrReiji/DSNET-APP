import 'package:dorm_gym/models/ConnectionHandler.dart';
import 'package:dorm_gym/widgets/ComplexDrawer.dart';
import 'package:dorm_gym/widgets/GymScreenWidgets/GS_Slot.dart';
import 'package:dorm_gym/widgets/GymScreenWidgets/GS_TableHeader.dart';
import 'package:flutter/material.dart';

import '../widgets/GymScreenWidgets/GS_ReservationButton.dart';

List<String> resInfo = [];

class GymScreen extends StatefulWidget {
  GymScreen({super.key}) {
    ConnectionHandler.getData(
            "https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/2889")
        .then(
      (document) {
        var content = document
            .querySelector('.table.reservation.general.table-sm.single')!
            .children;
        var resContent = content[1].text.trim().split('\n');
        //print(resContent);
        //[2].trim().split(' ');
        List<String> resContElems;
        List<String> separated;

        for (String resContElem in resContent) {
          resContElems = resContElem.trim().split(' ');
          //print(resContElems);
          resContElems.removeWhere((element) => element == '');
          resContElems[resContElems.length - 1] =
              resContElems[resContElems.length - 1].replaceAllMapped(
                  RegExp(r'([a-zA-Z])(\d)'),
                  (match) => '${match.group(1)} ${match.group(2)}');
          separated = resContElems[resContElems.length - 1].split(" ");
          resContElems.removeLast();
          resContElems.add(separated[0]);
          if (resContElems.length == 1) {
            resInfo.add(separated[0]);
          }
          if (resContElems.length == 4) {
            resInfo.add(resContElems[0] + " " + resContElems[1]);
            resInfo.add(resContElems[2] + " " + resContElems[3]);
          } else if ((resContElems.length == 3)) {
            resInfo.add(resContElems[0]);
            resInfo.add(resContElems[1] + " " + resContElems[2]);
          }
          if (separated.length > 1) {
            resInfo.add(separated[1]);
          }
        }
        print(resInfo);

        //lista = resContent;
      },
    );
  }

  static const routeName = '/gym';

  @override
  State<GymScreen> createState() => _GymScreenState();
}

class _GymScreenState extends State<GymScreen> {
  @override
  Widget build(BuildContext context) {
    final screenName = ModalRoute.of(context)!.settings.arguments as String;
    const double _height = 40;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: IconTheme.of(context).copyWith(
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          screenName,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      drawer: ComplexDrawer(),
      body: Column(
        children: [
          GS_TableHeader(),
          Container(
            height: MediaQuery.of(context).size.height - 110,
            child: SingleChildScrollView(
              child: Table(
                border: TableBorder.all(color: Colors.grey.shade200),
                columnWidths: <int, TableColumnWidth>{
                  0: FixedColumnWidth(
                      2 * MediaQuery.of(context).size.width / 8),
                  1: FixedColumnWidth(
                      3 * MediaQuery.of(context).size.width / 8),
                  2: FixedColumnWidth(
                      3 * MediaQuery.of(context).size.width / 8),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: List.generate(
                  32,
                  (index) => TableRow(
                    children: <Widget>[
                      TableCell(
                        child: Container(
                          height: _height,
                          color: Colors.grey.shade200,
                          child: Center(
                            child: Text(
                              '${resInfo[0 + index * 4]}\n${resInfo[1 + index * 4]}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                            height: _height,
                            color: Colors.grey.shade200,
                            child: GS_ReservationButton(
                              buttonText: 'rezerwuj',
                              buttonColor: Colors.blue,
                            )),
                      ),
                      TableCell(
                        child: Container(
                          height: _height,
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Text(
                              "Za wcześnie",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
