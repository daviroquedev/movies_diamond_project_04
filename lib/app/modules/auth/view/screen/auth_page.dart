import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/auth/service/googleAuth/google_auth_sign_in.dart';
import 'package:movies_diamond_project_03/app/modules/auth/view/components/buttons_custom.dart';

class AuthPage extends StatelessWidget {
  final CustomButtons customButtons =
      CustomButtons(); // Instância da classe de botões

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/diamond_logo.png',
          height: 70,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            customButtons.buildElevatedButton(
              text: 'LOGIN',
              onPressed: () {
                // lógica de login
                Modular.to.navigate('/');
              },
              buttonColor: Colors.blue,
            ),
            const SizedBox(height: 20),
            customButtons.buildElevatedButton(
              text: 'LOGAR COM GOOGLE',
              onPressed: () {
                SignInScreen signInScreen = SignInScreen();

                signInScreen.handleSignIn();
                // lógica de login com o Google
              },
              buttonColor: Colors.blue,
              icon: const Icon(Icons.account_circle, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
