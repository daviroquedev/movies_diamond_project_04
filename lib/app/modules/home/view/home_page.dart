import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/components/carrousel_cards.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/diamond_logo.png',
          fit: BoxFit.cover,
          height: 90,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 1,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/diamond_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 180,
              ),
              SizedBox(
                width: 300, // Definindo uma largura fixa para os botões
                height: 50, // Definindo uma altura fixa para os botões
                child: ElevatedButton(
                  onPressed: () => Modular.to.navigate('/movies/'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'ENTRAR COMO VISITANTE',
                    style: TextStyle(fontSize: 18, color: Colors.yellow),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300, // Definindo uma largura fixa para os botões
                height: 50, // Definindo uma altura fixa para os botões
                child: ElevatedButton(
                  onPressed: () => Modular.to.navigate('/auth/'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'TENHO UMA CONTA',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 255, 0, 0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
