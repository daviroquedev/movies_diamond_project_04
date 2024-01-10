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
    final GoogleSignInAccount? googleUser = await signInWithGoogle();

    if (googleUser != null) {
      setUserDetails(googleUser);

      try {
        const String apiKey = '9598d00230dc09769db0762336124969';
        final String requestToken = await getRequestToken(apiKey);

        print('REQUEST TOKEN $requestToken');

        await addRequestTokenToUserInFirestore(requestToken);

        // print('TENTANDO ABRIR A URL');

        // try {
        //   await authApi.requestUserPermission(requestToken);
        //   print('era pra ta aberta');
        // } catch (e) {
        //   print(e);
        // }

        print('era pra ta aberta');
      } catch (e) {
        print('Error adding user/session: $e');
      }

      printUserDetails();

      Modular.to.pushNamed('/movies/');
    }
  }

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    return await googleSignIn.signIn();
  }

  void setUserDetails(GoogleSignInAccount googleUser) {
    userStore.setUserDetails(
      name: googleUser.displayName ?? 'TESTE',
      email: googleUser.email ?? '',
      photoUrl: googleUser.photoUrl ?? '',
    );
  }

  Future<String> getRequestToken(String apiKey) async {
    return await authApi.requestToken(apiKey);
  }

  Future<void> addRequestTokenToUserInFirestore(String requestToken) async {
    final db = FirebaseFirestore.instance;
    final docRef = await db.collection("users").add({
      "name": userStore.userName,
      "email": userStore.userEmail,
    });

    await db.collection("users").doc(docRef.id).update({
      "request_token": requestToken,
    });

    print('REQUEST TOKEN added to user in Firestore: $requestToken');
  }

  void printUserDetails() {
    print('Detalhes do usuário alterados:');
    print('Name: ${userStore.userName}');
    print('Email: ${userStore.userEmail}');
    print('PhotoUrl: ${userStore.userPhotoUrl}');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
