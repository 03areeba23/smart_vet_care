import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_vet_care/model/chat_doctor.dart';
import 'package:smart_vet_care/screen/ChatDetailScreen.dart';
import 'package:smart_vet_care/screen/pet_owner_screens/BookAppointScreen.dart';
import 'package:smart_vet_care/screen/pet_owner_screens/PO_HomeScreen.dart';

import '../Widget/DetailCell.dart';

class DocInfo extends StatefulWidget {
  final ChatDoctor doc;

  const DocInfo({super.key, required this.doc,});

  @override
  State<DocInfo> createState() => _DocInfoState();
}

class _DocInfoState extends State<DocInfo> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titleSection(),
                const SizedBox(height: 8,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. ${widget.doc.firstname} ${widget.doc.lastname}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.location_solid,
                            size: 20,
                            color: Colors.red.shade800,
                          ),
                          const SizedBox(width: 4,),
                          Text(
                            widget.doc.hosptialName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent.shade100,
                          border: Border.all(color: Colors.deepPurpleAccent.shade200, width: 1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${widget.doc.speciality} ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32,),
                      Text(
                        'I am your Doctor',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 32,),
                      SizedBox(
                        height: 91,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            DetailCell(title: '162', subTitle: 'Patients'),
                            DetailCell(title: '4+', subTitle: 'Exp. Years'),
                            DetailCell(title: '4.5', subTitle: 'Rating'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32,),
                      Center(
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple, side: BorderSide.none, shape: StadiumBorder()
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BookAppointment()));
                            },
                            child: const Text('Book Appointment', style: TextStyle(fontSize: 18),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.deepPurpleAccent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, size: 30,),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Container _titleSection() {
    return Container(
      height: 250,
      color: Colors.deepPurpleAccent,
      child: Stack(
        children: [
          Positioned(
            right: 120,
            bottom: 70,
            child: Center(
              child: SizedBox(
                width: 170,
                height: 170,
                child: Hero(
                  tag: widget.doc.firstname + ' '+ widget.doc.lastname,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fitHeight,
                      image: NetworkImage(widget.doc.image),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 15,
              color: Colors.white,
            ),
          ),
          Positioned(
            right: 32,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 4,),
                  IconButton(
                    icon: Icon(CupertinoIcons.chat_bubble_fill),
                    color: Colors.blue,
                    iconSize: 30,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetail(doctor: widget.doc)));
                    },
                  ),
                ],
              ),
            )
            /*Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.yellowAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(
                    '4.5',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4,),
                  const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 14,
                  ),
                ],
              ),
            ),*/
          ),
        ],
      ),
    );
  }
}
