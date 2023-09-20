import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_vet_care/model/chat_doctor.dart';

import '../screen/pet_owner_screens/PO_HomeScreen.dart';

class PrimaryCard extends StatelessWidget {
  final ChatDoctor doc;

  PrimaryCard({required this.doc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(
              tag: doc.firstname,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                      image: NetworkImage(doc.image), fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            doc.firstname + ' ' +doc.lastname,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            width: 2.0,
          ),
          /*Text(
            doc.lastname,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            height: 5.0,
          ),*/
          Row(
            children: [
              Icon(CupertinoIcons.location_solid, color: Colors.red.shade800, size: 20,),
              Text(
                doc.hosptialName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.deepPurple.shade400),
              )
            ],
          )
        ],
      ),
    );
  }
}
