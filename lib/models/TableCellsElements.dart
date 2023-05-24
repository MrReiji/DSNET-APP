import 'package:flutter/material.dart';

import '../widgets/ReservationButtons.dart';

class DayTableCell extends StatelessWidget {
  const DayTableCell({
    super.key,
    required this.height,
    required this.daysFromToday,
  });

  final double height;
  final int daysFromToday;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        height: height,
        color: Colors.green.shade100,
        child: Center(
          child: Text(
            DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day + daysFromToday)
                .toString()
                .substring(0, 10),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class HoursTableCell extends StatelessWidget {
  const HoursTableCell({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        height: height,
        color: Colors.green.shade100,
        child: const Center(
          child: Text(
            "Godzina",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class ContentHourTableCell extends StatelessWidget {
  const ContentHourTableCell({
    super.key,
    required this.height,
    required this.snapshot,
    required this.textWidget,
  });

  final double height;
  final AsyncSnapshot<List<String>> snapshot;
  final Widget textWidget;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        height: height,
        color: Colors.grey.shade200,
        child: Center(
          child: snapshot.connectionState == ConnectionState.waiting
              ? const Text('Loading...')
              : snapshot.hasError
                  ? Text('Error: ${snapshot.error}')
                  : textWidget,
        ),
      ),
    );
  }
}

class ContentTableCell extends StatelessWidget {
  const ContentTableCell({
    super.key,
    required this.height,
    required this.snapshot,
    required this.indexInReservationInfo,
    required this.multiplier,
    required this.index,
    required this.numOfUrlPlace,
    required this.url,
    required this.daysFromToday,
    required this.refreshScreen,
  });

  final double height;
  final AsyncSnapshot<List<String>> snapshot;
  final int indexInReservationInfo;
  final int index;
  final int numOfUrlPlace;
  final String url;
  final int daysFromToday;
  final VoidCallback refreshScreen;
  final int multiplier;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        height: height,
        color: Colors.grey.shade200,
        child: Center(
          child: snapshot.connectionState == ConnectionState.waiting
              ? const Text(
                  'Loading...',
                  textAlign: TextAlign.center,
                )
              : snapshot.hasError
                  ? Text(
                      'Error: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    )
                  : snapshot.data?[
                              indexInReservationInfo + index * multiplier] ==
                          "rezerwuj"
                      ? ReservationButton(
                          url: url,
                          daysFromToday: daysFromToday,
                          rowNumber: index,
                          numOfUrlPlace: numOfUrlPlace,
                          refreshScreen: refreshScreen,
                        )
                      : snapshot.data?[indexInReservationInfo +
                                  index * multiplier] ==
                              "Twoja rezerwacja"
                          ? const ReservationText()
                          : snapshot.data?[indexInReservationInfo +
                                      index * multiplier] ==
                                  "Twoja rezerwacja usuń"
                              ? Column(
                                  children: [
                                    const ReservationText(),
                                    RemoveReservationButton(
                                        url: url, refreshScreen: refreshScreen)
                                  ],
                                )
                              : Text(
                                  '${snapshot.data?[indexInReservationInfo + index * multiplier]}',
                                  textAlign: TextAlign.center,
                                ),
        ),
      ),
    );
  }
}

class ReservationText extends StatelessWidget {
  const ReservationText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Twoja rezerwacja',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      textAlign: TextAlign.center,
    );
  }
}
