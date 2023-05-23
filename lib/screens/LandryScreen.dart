import 'package:dorm_gym/models/DataHandler.dart';
import 'package:dorm_gym/widgets/LaundryScreenWidgets/LS_TableHeader.dart';
import 'package:flutter/material.dart';

import '../models/TableCellsElements.dart';
import '../widgets/ComplexDrawer.dart';
import '../widgets/ReservationButtons.dart';

class LaundryScreen extends StatefulWidget {
  const LaundryScreen({super.key});

  static const routeName = '/laundry';

  @override
  State<LaundryScreen> createState() => _LaundryScreenState();
}

class _LaundryScreenState extends State<LaundryScreen> {
  String url = "https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/2294";
  late Future<List<String>> _reservationInfo;

  @override
  void initState() {
    _reservationInfo =
        DataHandler.getReservationsInfo(url, reservationPlace.LAUNDRY);

    super.initState();
  }

  void refreshScreen() {
    setState(() {
      _reservationInfo =
          DataHandler.getReservationsInfo(url, reservationPlace.LAUNDRY);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenName = ModalRoute.of(context)!.settings.arguments as String;
    double _height = MediaQuery.of(context).size.height / 9;

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
                          ContentTableCell(
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
                            textWidget: snapshot.data?[2 + index * 5] ==
                                    "rezerwuj"
                                ? ReservationButton(
                                    url: url,
                                    daysFromToday: 0,
                                    rowNumber: index,
                                    refreshScreen: refreshScreen,
                                  )
                                : snapshot.data?[2 + index * 5] ==
                                        "Twoja rezerwacja"
                                    ? const ReservationText()
                                    : snapshot.data?[2 + index * 5] ==
                                            "Twoja rezerwacja usuń"
                                        ? Column(
                                            children: [
                                              const ReservationText(),
                                              RemoveReservationButton(
                                                  url: url,
                                                  refreshScreen: refreshScreen)
                                            ],
                                          )
                                        : Text(
                                            '${snapshot.data?[2 + index * 5]}',
                                            textAlign: TextAlign.center,
                                          ),
                          ),
                          ContentTableCell(
                            height: _height,
                            snapshot: snapshot,
                            textWidget:
                                snapshot.data?[3 + index * 5] == "rezerwuj"
                                    ? ReservationButton(
                                        url:
                                            'https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/2294',
                                        daysFromToday: 1,
                                        rowNumber: index,
                                        refreshScreen: refreshScreen,
                                      )
                                    : snapshot.data?[3 + index * 5] ==
                                            "Twoja rezerwacja"
                                        ? const ReservationText()
                                        : snapshot.data?[3 + index * 5] ==
                                                "Twoja rezerwacja usuń"
                                            ? Center(
                                                child: Column(
                                                  children: [
                                                    const ReservationText(),
                                                    RemoveReservationButton(
                                                        url: url,
                                                        refreshScreen:
                                                            refreshScreen)
                                                  ],
                                                ),
                                              )
                                            : Text(
                                                '${snapshot.data?[3 + index * 5]}',
                                                textAlign: TextAlign.center,
                                              ),
                          ),
                          ContentTableCell(
                            height: _height,
                            snapshot: snapshot,
                            textWidget:
                                snapshot.data?[4 + index * 5] == "rezerwuj"
                                    ? ReservationButton(
                                        url:
                                            'https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/2294',
                                        daysFromToday: 2,
                                        rowNumber: index,
                                        refreshScreen: refreshScreen,
                                      )
                                    : snapshot.data?[4 + index * 5] ==
                                            "Twoja rezerwacja"
                                        ? const ReservationText()
                                        : snapshot.data?[4 + index * 5] ==
                                                "Twoja rezerwacja usuń"
                                            ? Center(
                                                child: Column(
                                                  children: [
                                                    const ReservationText(),
                                                    RemoveReservationButton(
                                                        url: url,
                                                        refreshScreen:
                                                            refreshScreen)
                                                  ],
                                                ),
                                              )
                                            : Text(
                                                '${snapshot.data?[4 + index * 5]}',
                                                textAlign: TextAlign.center,
                                              ),
                          ),
                          ContentTableCell(
                            height: _height,
                            snapshot: snapshot,
                            textWidget:
                                snapshot.data?[5 + index * 5] == "rezerwuj"
                                    ? ReservationButton(
                                        url:
                                            'https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/2294',
                                        daysFromToday: 3,
                                        rowNumber: index,
                                        refreshScreen: refreshScreen,
                                      )
                                    : snapshot.data?[5 + index * 5] ==
                                            "Twoja rezerwacja"
                                        ? const ReservationText()
                                        : snapshot.data?[5 + index * 5] ==
                                                "Twoja rezerwacja usuń"
                                            ? Center(
                                                child: Column(
                                                  children: [
                                                    const ReservationText(),
                                                    RemoveReservationButton(
                                                        url: url,
                                                        refreshScreen:
                                                            refreshScreen)
                                                  ],
                                                ),
                                              )
                                            : Text(
                                                '${snapshot.data?[5 + index * 5]}',
                                                textAlign: TextAlign.center,
                                              ),
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
