import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const DetailCard({Key? key, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      width: 150,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12)
      ),
      child: Stack(
        children: [
          Positioned(
             left: 0,
              bottom: 0,
              child: Container(
                width: 100,
                height: 70,
              ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),),
              SizedBox(height: 4.0,),
              Text(
                subtitle, style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700
              ),
              ),
              SizedBox(height: 15,)
            ],
          ),
        ],
      ),
    );
  }
}
