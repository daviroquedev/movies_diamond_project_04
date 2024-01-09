import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_diamond_project_03/app/modules/auth/service/moviedbService/moviedb_auth_service.dart';
import 'package:movies_diamond_project_03/app/modules/auth/store/auth_google_store.dart';

class SignInScreen extends StatelessWidget {
  final UserStore userStore = Modular.get();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final AuthApi authApi = Modular.get();

  SignInScreen({super.key});

  Future<void> handleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      userStore.setUserDetails(
        name: googleUser.displayName ?? 'TESTE',
        email: googleUser.email ?? '',
        photoUrl: googleUser.photoUrl ?? '',
      );

      final user = <String, dynamic>{
        "name": "${googleUser.displayName}",
        "email": googleUser.email,
      };

      try {
        final db = FirebaseFirestore.instance;
        final docRef = await db.collection("users").add(user);
        final String apiKey = '9598d00230dc09769db0762336124969';

        print('DocumentSnapshot added with ID: ${docRef.id}');

        // Chamada para criar session_id e associá-lo ao usuário no Firestore
        final requestToken = await authApi
            .requestToken(apiKey // Substitua pelo seu API key do The Movie DB
                // Substitua pelo seu token de solicitação (se aplicável)
                );

        print('REQUEST TOKENNNNNNNNNNNNN $requestToken');

        // Associar o session_id ao documento do usuário recém-criado
        await db.collection("users").doc(docRef.id).update({
          "request_token": requestToken,
        });

        print('REQUEST TOKEN added to user in Firestore: $requestToken');
      } catch (e) {
        print('Error adding user/session: $e');
      }

      print('Detalhes do usuário alterados:');
      print('Name: ${userStore.userName}');
      print('Email: ${userStore.userEmail}');
      print('PhotoUrl: ${userStore.userPhotoUrl}');

      Modular.to.pushNamed('/movies/');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
