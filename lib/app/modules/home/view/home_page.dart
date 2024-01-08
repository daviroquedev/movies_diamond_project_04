import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/diamond_logo.png',
          fit: BoxFit.cover,
          height: 60,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
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
            onPressed: () => Modular.to.navigate('/auth/'),
            child: const Text('auth'),
          ),
        ],
      ),
    );
  }
}
