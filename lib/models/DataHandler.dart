import 'package:flutter/material.dart' hide Element;
import 'package:html/dom.dart' hide Text;

import 'ConnectionHandler.dart';

enum ReservationPlace { GYM, LAUNDRY }

class DataHandler {
  static Future<List<String>> getReservationsInfo(
      String url, ReservationPlace resPlace) async {
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

        if (resPlace == ReservationPlace.GYM) {
          switch (slotContentElemParts.length) {
            //When there is only a hour
            case 1:
              reservationInfo.add(slotContentElemParts[0]);
              break;
            //When there are 2 book options available
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
            //When there are 2 booked slots or not available ones or your booked slot
            case 4:
              //When there are 2 booked slots or not available ones
              if (slotContentElemParts[0] != "rezerwuj" &&
                  slotContentElemParts[0] != "Twoja") {
                reservationInfo.add(
                    slotContentElemParts[0] + " " + slotContentElemParts[1]);
                reservationInfo.add(
                    slotContentElemParts[2] + " " + slotContentElemParts[3]);
                //When there is one book option and your booked slot
              } else if (slotContentElemParts[0] == "rezerwuj") {
                reservationInfo.add(slotContentElemParts[0]);
                reservationInfo.add(slotContentElemParts[1] +
                    " " +
                    slotContentElemParts[2] +
                    slotContentElemParts[3]);
                //When there is one booked or not available option and your booked slot
              } else {
                reservationInfo.add(
                    slotContentElemParts[0] + " " + slotContentElemParts[1]);
                reservationInfo.add(
                    slotContentElemParts[2] + " " + slotContentElemParts[3]);
              }
              break;
            case 5:
              //When there is one booked or not available option and your fresh booked slot
              if (slotContentElemParts[0] != "Twoja") {
                reservationInfo.add(
                    slotContentElemParts[0] + " " + slotContentElemParts[1]);
                reservationInfo.add(slotContentElemParts[2] +
                    " " +
                    slotContentElemParts[3] +
                    " " +
                    slotContentElemParts[4]);
              } else {
                reservationInfo.add(slotContentElemParts[0] +
                    " " +
                    slotContentElemParts[1] +
                    " " +
                    slotContentElemParts[2]);
                reservationInfo.add(
                    slotContentElemParts[3] + " " + slotContentElemParts[4]);
              }

              break;
          }
          //When there are 2 elements, second one is the start of a new slot
          if (separated.length == 2) {
            reservationInfo.add(separated[1]);
          }
        }
//------------------------------------------------------------------------------------

        else if (resPlace == ReservationPlace.LAUNDRY) {
          //When there is only a hour
          if (slotContentElemParts.length == 1) {
            reservationInfo.add(slotContentElemParts[0]);
          }
          //When there are 4 book options available
          else if (slotContentElemParts.length == 4) {
            reservationInfo.addAll(slotContentElemParts);
          }
          //When there are situations, when at least one slot is booked
          else {
            for (String elem in slotContentElemParts) {
              //When specific slot is not booked
              if (elem == "rezerwuj") {
                reservationInfo.add(elem);
              }
              //When someone booked a slot
              else if ((RegExp(r'^[0-9]+A?$').hasMatch(elem)) ||
                  elem == "Za" ||
                  elem == "Termin" ||
                  elem == "Limit") {
                reservationInfo.add(elem +
                    " " +
                    slotContentElemParts[
                        slotContentElemParts.indexOf(elem) + 1]);
              }
              //When you booked a slot
              else if (elem == "Twoja") {
                reservationInfo.add(elem +
                    " " +
                    slotContentElemParts[
                        slotContentElemParts.indexOf(elem) + 1]);
                //When you did it earlier
                if (slotContentElemParts[
                        slotContentElemParts.indexOf(elem) + 2] ==
                    "usuń") {
                  reservationInfo[reservationInfo.length - 1] =
                      reservationInfo[reservationInfo.length - 1] +
                          " " +
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
      return reservationInfo;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<String>> getFormActionList(
      String url, bool toDelete) async {
    try {
      List<String> formActions = [];
      Document document = await ConnectionHandler.getData(url);
      List<Element> buttons = document.querySelectorAll('[formaction]');
      for (Element button in buttons) {
        String formAction = button.attributes['formaction'] as String;
        if ((toDelete && formAction.contains('delete')) ||
            (!toDelete && !formAction.contains('delete'))) {
          formActions.add(formAction);
        } else {
          continue;
        }
      }
      print(formActions);
      return formActions;
    } catch (error) {
      rethrow;
    }
  }
}
