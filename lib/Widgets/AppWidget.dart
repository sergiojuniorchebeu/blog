import 'package:flutter/material.dart';

class AppWidget {

  static Widget customButton({
    required String text,
    VoidCallback? onPressed,
    Color color = Colors.blueAccent,
    double fontSize = 18,
    double padding = 15,
    Color textColor = Colors.white,
    double borderRadius = 30,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: padding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 5,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }

  // Titre de texte personnalisable
  static Widget customTitle({
    required String text,
    double fontSize = 30,
    Color color = Colors.black87,
    TextAlign textAlign = TextAlign.center,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: textAlign,
    );
  }

  // Fonction pour créer un style de texte
  static TextStyle customTextStyle({
    double fontSize = 16,
    Color color = Colors.grey,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }
}
