
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class AppThemeModel {
  final Color primaryColor;
  final Color backgroundColor;
  final Color textColor;
  final String logoAsset;
  final double buttonRadius;

  const AppThemeModel({
    required this.primaryColor,
    required this.backgroundColor,
    required this.textColor,
    required this.logoAsset,
    required this.buttonRadius,
  });
}


const AppThemeModel lightTheme = AppThemeModel(
  primaryColor: Color(0xFF2196F3),
  backgroundColor: Colors.white,
  textColor: Colors.black,
  logoAsset: 'assets/logo_blue.png',
  buttonRadius: 12,
);

const AppThemeModel darkTheme = AppThemeModel(
  primaryColor: Color(0xFFF44336),
  backgroundColor: Colors.white,
  textColor: Colors.black,
  logoAsset: 'assets/logo_red.png',
  buttonRadius: 8,
);
