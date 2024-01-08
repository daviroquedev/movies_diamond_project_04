import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_diamond_project_03/app/modules/auth/store/auth_google_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sign In',
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  final UserStore userStore = Modular.get();

  SignInScreen({super.key});

  Future<void> _handleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      print('ID: ${googleUser.id}');
      print('Nome: ${googleUser.displayName}');
      print('E-mail: ${googleUser.email}');
      print('URL da Foto: ${googleUser.photoUrl}');

      userStore.setUserDetails(
        name: googleUser.displayName ?? 'TESTE',
        email: googleUser.email ?? '',
        photoUrl: googleUser.photoUrl ?? '',
      );

      print('Detalhes do usuário alterados:');
      print('Name: ${userStore.userName}');
      print('Email: ${userStore.userEmail}');
      print('PhotoUrl: ${userStore.userPhotoUrl}');

      Modular.to.pushNamed('/movies/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sign In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _handleSignIn,
          child: const Text('Login com Google'),
        ),
      ),
    );
  }
}
