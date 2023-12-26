import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () => Modular.to.navigate('/movies/'),
              child: Text('FILMES'),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Modular.to.navigate('/movies/'),
            child: const Text('PERFIL'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Modular.to.navigate('/auth'),
            child: const Text('auth'),
          ),
        ],
      ),
    );
  }
}
