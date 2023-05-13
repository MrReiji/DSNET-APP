import 'package:dorm_gym/models/DataHandler.dart';
import 'package:dorm_gym/widgets/ComplexDrawer.dart';
import 'package:dorm_gym/widgets/GymScreenWidgets/GS_TableHeader.dart';
import 'package:flutter/material.dart';

import '../widgets/GymScreenWidgets/GS_ReservationButton.dart';

class GymScreen extends StatefulWidget {
  const GymScreen({super.key});

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenName = ModalRoute.of(context)!.settings.arguments as String;
    double _height = MediaQuery.of(context).size.height / 18;

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
          const GS_TableHeader(),
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
                                child: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? const Text('Loading hours...')
                                    : snapshot.hasError
                                        ? Text('Error: ${snapshot.error}')
                                        : Text(
                                            '${snapshot.data![0 + index * 4]}\n${snapshot.data![1 + index * 4]}'),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: _height,
                              color: Colors.grey.shade200,
                              child: Center(
                                child: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? const Text('Loading reservation...')
                                    : snapshot.hasError
                                        ? Text('Error: ${snapshot.error}')
                                        : snapshot.data![2 + index * 4] ==
                                                "rezerwuj"
                                            ? GS_ReservationButton(
                                                buttonText: "Rezerwuj",
                                                buttonColor: Colors.blue)
                                            : Text(
                                                snapshot.data![2 + index * 4]),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: _height,
                              color: Colors.grey.shade200,
                              child: Center(
                                child: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? const Text('Loading reservation...')
                                    : snapshot.hasError
                                        ? Text('Error: ${snapshot.error}')
                                        : snapshot.data![3 + index * 4] ==
                                                "rezerwuj"
                                            ? GS_ReservationButton(
                                                buttonText: "Rezerwuj",
                                                buttonColor: Colors.blue)
                                            : Text(
                                                snapshot.data![3 + index * 4]),
                              ),
                            ),
                          ),
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
