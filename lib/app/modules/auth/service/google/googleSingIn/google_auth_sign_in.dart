import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_diamond_project_03/app/modules/auth/service/google/firestore/firestore_service.dart';
import 'package:movies_diamond_project_03/app/modules/auth/service/moviedbService/moviedb_auth_service.dart';
import 'package:movies_diamond_project_03/app/modules/auth/store/auth_google_store.dart';
import 'package:movies_diamond_project_03/app/modules/movies/models/movies_models.dart';

class SignInScreen extends StatelessWidget {
  final UserStore userStore = Modular.get();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final AuthApi authApi = Modular.get();

  SignInScreen({super.key});

  Future<void> handleSignIn() async {
    final GoogleSignInAccount? googleUser = await signInWithGoogle();
    final FirestoreService firestoreService = FirestoreService(userStore);

    if (googleUser != null) {
      setUserDetails(googleUser);

      try {
        const String apiKey = '9598d00230dc09769db0762336124969';
        final String requestToken = await getRequestToken(apiKey);

        print('REQUEST TOKEN $requestToken');

        await firestoreService
            .addOrUpdateUserInFirestore(); // Chamada para verificar/atualizar usuário

        Modular.to.pushNamed('/movies/');
      } catch (e) {
        print('Error adding user/session: $e');
      }

      printUserDetails();
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

  // Future<Map<String, dynamic>?> addOrUpdateUserInFirestore() async {
  //   final db = FirebaseFirestore.instance;

  //   final userSnapshot = await db
  //       .collection("users")
  //       .where("email", isEqualTo: userStore.userEmail)
  //       .get();

  //   if (userSnapshot.docs.isNotEmpty) {
  //     final existingUser = userSnapshot.docs.first;
  //     final userData = existingUser.data() as Map<String, dynamic>;

  //     await existingUser.reference.update({
  //       "name": userStore.userName,
  //       "photoUrl": userStore.userPhotoUrl,
  //       // Outros detalhes que podem ser atualizados
  //     });

  //     print('User already exists. Details updated.');

  //     return userData;
  //   } else {
  //     await db.collection("users").add({
  //       "name": userStore.userName,
  //       "email": userStore.userEmail,
  //       "photoUrl": userStore.userPhotoUrl,
  //       // Outros detalhes do novo usuário
  //     });
  //     print('New user added to Firestore.');

  //     return null;
  //   }
  // }

  // Future<void> addFavoriteMovies(List<MoviesModels> favoriteMovies) async {
  //   final db = FirebaseFirestore.instance;

  //   final userSnapshot = await db
  //       .collection("users")
  //       .where("email", isEqualTo: userStore.userEmail)
  //       .get();

  //   if (userSnapshot.docs.isNotEmpty) {
  //     final existingUser = userSnapshot.docs.first;
  //     final userData = existingUser.data();

  //     List<dynamic> currentFavorites = userData['favorite_movies'] ?? [];

  //     // Converte cada objeto MoviesModels em um mapa (JSON)
  //     List<Map<String, dynamic>> favoriteMoviesJson =
  //         favoriteMovies.map((movie) => movie.toJson()).toList();

  //     // Adiciona os novos filmes à lista existente
  //     currentFavorites.addAll(favoriteMoviesJson);

  //     await existingUser.reference.update({
  //       "favorite_movies": currentFavorites,
  //     });

  //     print('Favorite movies added to user.');
  //   } else {
  //     print('User not found.');
  //   }
  // }

  // Future<void> removeFavoriteMovie(MoviesModels movie) async {
  //   final db = FirebaseFirestore.instance;

  //   final userSnapshot = await db
  //       .collection("users")
  //       .where("email", isEqualTo: userStore.userEmail)
  //       .get();

  //   if (userSnapshot.docs.isNotEmpty) {
  //     final existingUser = userSnapshot.docs.first;
  //     final userData = existingUser.data() as Map<String, dynamic>;

  //     List<dynamic> currentFavorites = userData['favorite_movies'] ?? [];

  //     // Converte cada objeto MoviesModels em um mapa (JSON)
  //     List<Map<String, dynamic>> currentFavoritesJson =
  //         currentFavorites.cast<Map<String, dynamic>>().toList();

  //     // Encontra e remove o filme específico da lista
  //     currentFavoritesJson
  //         .removeWhere((favoriteMovie) => favoriteMovie['id'] == movie.id);

  //     await existingUser.reference.update({
  //       "favorite_movies": currentFavoritesJson,
  //     });

  //     print('Favorite movie removed from user.');
  //   } else {
  //     print('User not found.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
