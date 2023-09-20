import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smart_vet_care/model/appointment_model.dart';


class AppointmentCard extends StatelessWidget {
  final Appointments appointments;
  const AppointmentCard({Key? key, required this.appointments}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String _dateFormatter(String timestamp) {
      String formattedDate =
      DateFormat('dd-MM-yyyy').format(DateTime.parse(timestamp));
      return formattedDate;
    }

    String _timeFormatter(String timestamp) {
      String formattedTime =
      DateFormat('kk:mm').format(DateTime.parse(timestamp));
      return formattedTime;
    }

    _compareDate(String date) {
      if (_dateFormatter(DateTime.now().toString())
          .compareTo(_dateFormatter(date)) ==
          0) {
        return true;
      } else {
        return false;
      }
    }

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  appointments.name,
                  style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              /*Text( appointments.pet,
                //_compareDate(appointments.date)
                //? 'TODAY' : '',
                style: GoogleFonts.lato(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),*/
              SizedBox(width: 170,),
              ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    //fixedSize: Size(40, 5),
                    backgroundColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    )
                  ),
                  child: Text('Accept', style: GoogleFonts.lato(color: Colors.deepPurple, fontSize: 14, fontWeight: FontWeight.bold),)
              ),
              const SizedBox(
                width: 0,
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(appointments.date,
              //_dateFormatter(
              //appointments.date.toString()
              //),
              style: GoogleFonts.lato(),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 20, right: 10, left: 16),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description: ${appointments.description}',
                        style: GoogleFonts.lato(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Time: ${appointments.time}',   //${_timeFormatter(appointments.date)},
                        style: GoogleFonts.lato(fontSize: 16),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.delete, color: Colors.black87,))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
