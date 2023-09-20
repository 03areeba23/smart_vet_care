import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final iconImagePath;
  final String categoryName;
  const CategoryCard({Key? key, this.iconImagePath, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 10.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.deepPurple.shade100,
        ),
        child: Row(
          children: [
            Image.asset(iconImagePath, height: 30,),
            SizedBox(width: 10,),
            Text(categoryName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
