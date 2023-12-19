import 'dart:ffi';

import 'package:flutter/material.dart';

class BMIResultScreen extends StatelessWidget {
  final int Age;
  final bool Ismale;
  final int Result;

  BMIResultScreen({
    required this.Age,
    required this.Ismale,
    required this.Result,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left,
          ),
        ),
        title: Text('BMI Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Gender : ${Ismale ? 'male' : 'Female'}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            Text(
              "Age : $Age",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,

              ),
            ),
            Text(
              "Result : $Result",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
