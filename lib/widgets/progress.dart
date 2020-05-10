import 'package:flutter/material.dart';

Container circularProgress() {
  return Container(
    child: Center(
      child:CircularProgressIndicator(
        valueColor:AlwaysStoppedAnimation(Colors.deepPurple) ,) ,),
  );
}