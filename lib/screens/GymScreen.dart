import 'package:dorm_gym/models/ConnectionHandler.dart';
import 'package:dorm_gym/models/DataHandler.dart';
import 'package:dorm_gym/widgets/ComplexDrawer.dart';
import 'package:dorm_gym/widgets/GymScreenWidgets/GS_TableHeader.dart';
import 'package:flutter/material.dart';

import '../widgets/GymScreenWidgets/GS_ReservationButton.dart';

class GymScreen extends StatefulWidget {
  GymScreen({super.key});

  static const routeName = '/gym';

  @override
  State<GymScreen> createState() => _GymScreenState();
}

class _GymScreenState extends State<GymScreen> {
  _GymScreenState();

  late Future<List<String>> _reservationInfo;

  @override
  void initState() {
    _reservationInfo = getReservationsInfo();
  }

  @override
  Widget build(BuildContext context) {
    final screenName = ModalRoute.of(context)!.settings.arguments as String;
    const double _height = 40;

    // print(_reservationInfo.length);
    // if (_reservationInfo.isEmpty) {
    //   print("Bylo tutaj");
    //   setState(() {});
    // }
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
                            child: FutureBuilder<List<String>>(
                              future: _reservationInfo, // async work
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<String>> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return Text('Loading....');
                                  default:
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return Text(
                                        '${snapshot.data![0 + index * 4]}\n${snapshot.data![1 + index * 4]}',
                                        textAlign: TextAlign.center,
                                      );
                                    }
                                }
                              },
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
