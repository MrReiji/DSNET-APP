import 'package:flutter/material.dart' hide Element;
import 'package:html/dom.dart' hide Text;

import 'ConnectionHandler.dart';

enum reservationPlace { GYM, LAUNDRY }

class DataHandler {
  static Future<List<String>> getReservationsInfo(
      String url, reservationPlace resPlace) async {
    try {
      Document document = await ConnectionHandler.getData(url);
      List<Element> content = document
          .querySelector('.table.reservation.general.table-sm.single')!
          .children;
      List<String> slotContent = content[1].text.trim().split('\n');

      List<String> slotContentElemParts;
      List<String> separated;
      List<String> reservationInfo = [];

      for (String slotContentElem in slotContent) {
        slotContentElemParts = slotContentElem.trim().split(' ');

        slotContentElemParts.removeWhere((element) => element == '');

        slotContentElemParts[slotContentElemParts.length - 1] =
            slotContentElemParts[slotContentElemParts.length - 1]
                .replaceAllMapped(RegExp(r'(\p{L}+)(\d)', unicode: true),
                    (match) => '${match.group(1)} ${match.group(2)}');

        separated =
            slotContentElemParts[slotContentElemParts.length - 1].split(" ");

        slotContentElemParts.removeLast();

        slotContentElemParts.add(separated[0]);

//------------------------------------------------------------------------------------

        if (resPlace == reservationPlace.GYM) {
          switch (slotContentElemParts.length) {
            //When there is only a hour
            case 1:
              reservationInfo.add(slotContentElemParts[0]);
              break;
            //When there are 2 book option available
            case 2:
              reservationInfo.addAll(slotContentElemParts);
              break;
            //When there is 1 book option available
            case 3:
              if (slotContentElemParts[0] == "rezerwuj") {
                reservationInfo.add(slotContentElemParts[0]);
                reservationInfo.add(
                    slotContentElemParts[1] + " " + slotContentElemParts[2]);
              } else {
                reservationInfo.add(
                    slotContentElemParts[0] + " " + slotContentElemParts[1]);
                reservationInfo.add(slotContentElemParts[2]);
              }
              break;
            //When there are 2 reservations or not available ones
            case 4:
              reservationInfo
                  .add(slotContentElemParts[0] + " " + slotContentElemParts[1]);
              reservationInfo
                  .add(slotContentElemParts[2] + " " + slotContentElemParts[3]);
              break;
          }
          //When there are 2 elements, second one is the start of a new slot
          if (separated.length == 2) {
            reservationInfo.add(separated[1]);
          }
        }
//------------------------------------------------------------------------------------

        else if (resPlace == reservationPlace.LAUNDRY) {
          print(slotContentElemParts);
          if (slotContentElemParts.length == 1) {
            reservationInfo.add(slotContentElemParts[0]);
          } else if (slotContentElemParts.length == 4) {
            reservationInfo.addAll(slotContentElemParts);
          } else {
            for (String elem in slotContentElemParts) {
              if (elem == "rezerwuj") {
                reservationInfo.add(elem);
              } else if ((RegExp(r'^[0-9]+A?$').hasMatch(elem)) ||
                  elem == "Za" ||
                  elem == "Termin" ||
                  elem == "Limit") {
                reservationInfo.add(elem +
                    " " +
                    slotContentElemParts[
                        slotContentElemParts.indexOf(elem) + 1]);
              } else if (elem == "Twoja") {
                reservationInfo.add(elem +
                    " " +
                    slotContentElemParts[
                        slotContentElemParts.indexOf(elem) + 1]);
                if (slotContentElemParts[
                        slotContentElemParts.indexOf(elem) + 2] ==
                    "usuń") {
                  reservationInfo[reservationInfo.length - 1] =
                      reservationInfo[reservationInfo.length - 1] +
                          "\n" +
                          slotContentElemParts[
                              slotContentElemParts.indexOf(elem) + 2];
                }
              } else {
                continue;
              }
            }
          }
        }
      }
      print(reservationInfo);
      return reservationInfo;
    } catch (error) {
      rethrow;
    }
  }
}
