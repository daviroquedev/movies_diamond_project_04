import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sign In',
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  Future<void> _handleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      // Obter as informações do perfil
      print('ID: ${googleUser.id}');
      print('Nome: ${googleUser.displayName}');
      print('E-mail: ${googleUser.email}');
      print('URL da Foto: ${googleUser.photoUrl}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _handleSignIn,
          child: Text('Login com Google'),
        ),
      ),
    );
  }
}
