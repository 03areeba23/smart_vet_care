import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

import '../screen/pet_owner_screens/PO_HomeScreen.dart';


class RatingCard extends StatelessWidget {
  final Doctor doc;
  const RatingCard({Key? key, required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Dr. ${doc.fname} ${doc.lname}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              doc.docType,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 8,),
        SmoothStarRating(
          starCount: 5,
          rating: doc.rating,
          color: Colors.amber,
          borderColor: Colors.amber,
        ),
      ],
    );
  }
}

