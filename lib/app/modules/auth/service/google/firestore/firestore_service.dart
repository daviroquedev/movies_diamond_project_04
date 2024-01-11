import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_diamond_project_03/app/modules/auth/service/moviedbService/moviedb_auth_service.dart';
import 'package:movies_diamond_project_03/app/modules/auth/store/auth_google_store.dart';
import 'package:movies_diamond_project_03/app/modules/movies/models/movies_models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final UserStore userStore;

  FirestoreService(this.userStore);
  Future<Map<String, dynamic>?> addOrUpdateUserInFirestore() async {
    if (userStore.userEmail == null) {
      // O email do usuário é nulo, então não execute nenhuma operação.
      return null;
    }

    final userSnapshot = await _db
        .collection("users")
        .where("email", isEqualTo: userStore.userEmail)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      _updateExistingUser(userSnapshot.docs.first);
      final updatedUserSnapshot = await userSnapshot.docs.first.reference.get();
      return updatedUserSnapshot.data() as Map<String, dynamic>;
    } else {
      _addNewUser();
      return null;
    }
  }

  void _updateExistingUser(DocumentSnapshot existingUser) async {
    await existingUser.reference.update({
      "name": userStore.userName,
      "photoUrl": userStore.userPhotoUrl,
      // alterar info
    });

    print('User already exists. Details updated.');
  }

  void _addNewUser() async {
    await _db.collection("users").add({
      "name": userStore.userName,
      "email": userStore.userEmail,
      "photoUrl": userStore.userPhotoUrl,
      // add mais detalhes do novo usuário
    });

    print('New user added to Firestore.');
  }

  Future<void> addFavoriteMovies(List<MoviesModels> favoriteMovies) async {
    final userSnapshot = await _db
        .collection("users")
        .where("email", isEqualTo: userStore.userEmail)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      final existingUser = userSnapshot.docs.first;
      final userData = existingUser.data();

      List<dynamic> currentFavorites = userData['favorite_movies'] ?? [];

      List<Map<String, dynamic>> favoriteMoviesJson =
          favoriteMovies.map((movie) => movie.toJson()).toList();

      currentFavorites.addAll(favoriteMoviesJson);

      await existingUser.reference.update({
        "favorite_movies": currentFavorites,
      });

      print('Favorite movies added to user.');
    } else {
      print('User not found.');
    }
  }

  Future<void> removeFavoriteMovie(MoviesModels movie) async {
    final userSnapshot = await _db
        .collection("users")
        .where("email", isEqualTo: userStore.userEmail)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      final existingUser = userSnapshot.docs.first;
      final userData = existingUser.data() as Map<String, dynamic>;

      List<dynamic> currentFavorites = userData['favorite_movies'] ?? [];

      List<Map<String, dynamic>> currentFavoritesJson =
          currentFavorites.cast<Map<String, dynamic>>().toList();

      currentFavoritesJson
          .removeWhere((favoriteMovie) => favoriteMovie['id'] == movie.id);

      await existingUser.reference.update({
        "favorite_movies": currentFavoritesJson,
      });

      print('Favorite movie removed from user.');
    } else {
      print('User not found.');
    }
  }
}
