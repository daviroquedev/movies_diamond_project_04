import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void showLoginPrompt(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Você está deslogado!',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Logue e salve seus filmes favoritos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2,
        actions: [
          Container(
            margin: const EdgeInsets.only(
                right: 8.0), // Ajuste a margem conforme necessário
            child: TextButton(
              onPressed: () {
                Modular.to.pushNamed('/auth/');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Borda quadrada
                  ),
                ),
              ),
              child: const Text(
                'LOGAR',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                right: 8.0), // Ajuste a margem conforme necessário
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Borda quadrada
                  ),
                ),
              ),
              child: const Text(
                'VOLTAR',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      );
    },
  );
}
