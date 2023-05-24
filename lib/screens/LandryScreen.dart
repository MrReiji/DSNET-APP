import 'package:dorm_gym/models/DataHandler.dart';
import 'package:dorm_gym/widgets/LaundryScreenWidgets/LS_TableHeader.dart';
import 'package:flutter/material.dart';

import '../models/TableCellsElements.dart';
import '../widgets/ComplexDrawer.dart';

class LaundryScreen extends StatefulWidget {
  const LaundryScreen(
      {super.key, required this.url, required this.washerNumber});

  static String routeName = '/laundry';
  final String url;
  final int washerNumber;

  @override
  State<LaundryScreen> createState() => _LaundryScreenState();
}

class _LaundryScreenState extends State<LaundryScreen> {
  //String url = "https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/2294";
  late Future<List<String>> _reservationInfo;
  late String url;
  late int washerNumber;
  late String routeName;
  @override
  void initState() {
    url = widget.url;
    _reservationInfo =
        DataHandler.getReservationsInfo(url, ReservationPlace.LAUNDRY);
    washerNumber = widget.washerNumber;
    routeName = LaundryScreen.routeName;

    super.initState();
  }

  void refreshScreen() {
    setState(() {
      _reservationInfo =
          DataHandler.getReservationsInfo(url, ReservationPlace.LAUNDRY);
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height / 9;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: IconTheme.of(context).copyWith(
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          "Pralka $washerNumber",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (washerNumber != 1) {
                washerNumber--;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LaundryScreen(
                      url:
                          'https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/229${3 + washerNumber}',
                      washerNumber: washerNumber,
                    ),
                  ),
                );
              }
            },
            splashRadius: 25,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                if (washerNumber != 5) {
                  washerNumber++;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LaundryScreen(
                        url:
                            'https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/229${3 + washerNumber}',
                        washerNumber: washerNumber,
                      ),
                    ),
                  );
                }
              },
              splashRadius: 25,
            ),
          ),
        ],
      ),
      drawer: ComplexDrawer(),
      body: Column(
        children: [
          LS_TableHeader(),
          SizedBox(
            height: MediaQuery.of(context).size.height - 110,
            child: SingleChildScrollView(
              child: FutureBuilder<List<String>>(
                future: _reservationInfo, // async work
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>> snapshot) {
                  return Table(
                    border: TableBorder.all(color: Colors.grey.shade200),
                    columnWidths: <int, TableColumnWidth>{
                      0: FixedColumnWidth(
                          2 * MediaQuery.of(context).size.width / 14),
                      1: FixedColumnWidth(
                          3 * MediaQuery.of(context).size.width / 14),
                      2: FixedColumnWidth(
                          3 * MediaQuery.of(context).size.width / 14),
                      3: FixedColumnWidth(
                          3 * MediaQuery.of(context).size.width / 14),
                      4: FixedColumnWidth(
                          3 * MediaQuery.of(context).size.width / 14),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: List.generate(
                      8,
                      (index) => TableRow(
                        children: <Widget>[
                          ContentHourTableCell(
                            height: _height,
                            snapshot: snapshot,
                            textWidget: index == 0
                                ? Text(
                                    '${snapshot.data?[0]}\n${snapshot.data?[1]}',
                                    textAlign: TextAlign.center,
                                  )
                                : Text(
                                    '${snapshot.data?[1 + (index - 1) * 5]}\n${snapshot.data?[6 + (index - 1) * 5]}',
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                          ContentTableCell(
                            height: _height,
                            snapshot: snapshot,
                            index: index,
                            numOfUrlPlace: 2327,
                            indexInReservationInfo: 2,
                            multiplier: 5,
                            daysFromToday: 0,
                            url: url,
                            refreshScreen: refreshScreen,
                          ),
                          ContentTableCell(
                            height: _height,
                            snapshot: snapshot,
                            index: index,
                            numOfUrlPlace: 2327,
                            indexInReservationInfo: 3,
                            multiplier: 5,
                            daysFromToday: 1,
                            url: url,
                            refreshScreen: refreshScreen,
                          ),
                          ContentTableCell(
                            height: _height,
                            snapshot: snapshot,
                            index: index,
                            numOfUrlPlace: 2327,
                            indexInReservationInfo: 4,
                            multiplier: 5,
                            daysFromToday: 2,
                            url: url,
                            refreshScreen: refreshScreen,
                          ),
                          ContentTableCell(
                            height: _height,
                            snapshot: snapshot,
                            index: index,
                            numOfUrlPlace: 2327,
                            indexInReservationInfo: 5,
                            multiplier: 5,
                            daysFromToday: 3,
                            url: url,
                            refreshScreen: refreshScreen,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
