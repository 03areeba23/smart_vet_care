import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_vet_care/screen/ChatDetailScreen.dart';

import '../screen/doctor_screens/DoctorHomeScreen.dart';


class SecondaryCard extends StatelessWidget{
  final PetOwnerDetails petOwnerDetails;
  SecondaryCard({required this.petOwnerDetails,});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(image: NetworkImage(petOwnerDetails.image), fit: BoxFit.cover)
            ),
          ),
          SizedBox(width: 12.0,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    petOwnerDetails.fname + ' '+ petOwnerDetails.lname,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'PTSans'),
                  ),
                  SizedBox(height: 4.0,),
                  Text(
                    petOwnerDetails.disease,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 4.0,),
                  Text(
                    petOwnerDetails.date + ' | ' + petOwnerDetails.time + 'pm',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white
                        ),
                        child: IconButton(
                          alignment: Alignment.center,
                          iconSize: 20,
                          icon: Icon(CupertinoIcons.chat_bubble_fill, color: Colors.deepPurple,),
                          onPressed: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetail()));
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  
}