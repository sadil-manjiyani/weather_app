import 'package:flutter/material.dart';

const primaryColor=Color(0xff87CEEB);
const textColor=Color(0xff333333);
const textColorSecondary=Color(0xff555555);
const secondaryColor=Color(0xffffffff);
const secondGradient=Color(0xffedfaff);
const buttonColor=Color(0xffffffff);
const backgroundLinearGradient=LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [
      0.1,
      0.5
    ],
    colors: [
      primaryColor,
      secondGradient
    ]
);

