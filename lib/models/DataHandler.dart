import 'package:flutter/material.dart';
import 'package:html/dom.dart' hide Text;

import 'ConnectionHandler.dart';

Future<List<String>> getReservationsInfo() async {
  try {
    Document document = await ConnectionHandler.getData(
        "https://panel.dsnet.agh.edu.pl/reserv/rezerwuj/2889");
    var content = document
        .querySelector('.table.reservation.general.table-sm.single')!
        .children;
    var slotContent = content[1].text.trim().split('\n');

    List<String> slotContentElemParts;
    List<String> separated;
    List<String> reservationInfo = [];

    for (String slotContentElem in slotContent) {
      slotContentElemParts = slotContentElem.trim().split(' ');

      slotContentElemParts.removeWhere((element) => element == '');

      slotContentElemParts[slotContentElemParts.length - 1] =
          slotContentElemParts[slotContentElemParts.length - 1]
              .replaceAllMapped(RegExp(r'([a-zA-Z])(\d)'),
                  (match) => '${match.group(1)} ${match.group(2)}');

      separated =
          slotContentElemParts[slotContentElemParts.length - 1].split(" ");

      slotContentElemParts.removeLast();

      slotContentElemParts.add(separated[0]);

      if (slotContentElemParts.length == 1) {
        reservationInfo.add(separated[0]);
      } else if (slotContentElemParts.length == 4) {
        reservationInfo
            .add(slotContentElemParts[0] + " " + slotContentElemParts[1]);
        reservationInfo
            .add(slotContentElemParts[2] + " " + slotContentElemParts[3]);
      } else if (slotContentElemParts.length == 3) {
        reservationInfo
            .add(slotContentElemParts[0] + " " + slotContentElemParts[1]);
        reservationInfo.add(slotContentElemParts[2]);
      }
      if (separated.length > 1) {
        reservationInfo.add(separated[1]);
      }
    }
    return reservationInfo;
  } catch (error) {
    rethrow;
  }
}
