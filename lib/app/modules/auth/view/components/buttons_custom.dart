import 'package:flutter/material.dart';

class CustomButtons {
  ElevatedButton buildElevatedButton({
    required String text,
    required VoidCallback onPressed,
    required Color buttonColor,
    Widget? icon,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor, // Define a cor de fundo do botão
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: icon,
                ),
              ],
              Text(
                text,
                style: TextStyle(color: Colors.white), // Cor do texto
              ),
            ],
          ),
        ),
      ),
    );
  }
}
