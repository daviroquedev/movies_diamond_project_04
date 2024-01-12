import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/auth/service/googleAuth/google_auth_sign_in.dart';
import 'package:movies_diamond_project_03/app/modules/movies/service/movie_detailed_service.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/components/dialog_error.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/screen/movie_detailed_page.dart';
import 'package:movies_diamond_project_03/app/modules/movies/models/movies_models.dart';
import 'package:shimmer/shimmer.dart';

class MovieCard extends StatefulWidget {
  final MoviesModels movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool isFavorited = false;
  bool isUserAuthenticated = false;

  @override
  void initState() {
    super.initState();
    checkIfFavorited();
  }

  Future<void> checkIfFavorited() async {
    SignInScreen signInScreen = SignInScreen();
    Map<String, dynamic>? userData =
        await signInScreen.addOrUpdateUserInFirestore();

    if (userData != null) {
      List<dynamic> favoriteMovies = userData['favorite_movies'] ?? [];
      setState(() {
        isFavorited =
            favoriteMovies.any((movie) => movie['id'] == widget.movie.id);
        isUserAuthenticated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieDetailsService = Modular.get<MovieDetailsService>();

    return GestureDetector(
      onTap: () {
        movieDetailsService.setSelectedMovie(widget.movie);
        Modular.to.pushNamed('/movies/detailed/${widget.movie.id}',
            arguments: widget.movie);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: _buildMovieImage(),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.black.withOpacity(0.5),
                      child: Text(
                        widget.movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () {
                        if (isUserAuthenticated) {
                          setState(() {
                            isFavorited = !isFavorited;
                          });
                          _saveToFavorites(widget.movie);
                        } else {
                          showLoginPrompt(context);
                          // Exibir algum aviso ou navegar para a tela de login
                          // ou realizar ação apropriada quando o usuário não estiver autenticado
                        }
                      },
                      child: Icon(
                        isFavorited ? Icons.star : Icons.star_border,
                        color: isFavorited
                            ? Colors.amberAccent
                            : (isUserAuthenticated ? null : Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieImage() {
    return Image.network(
      'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.white,
              height: 180,
            ),
          );
        }
      },
      fit: BoxFit.cover,
      height: 180,
    );
  }

  void _saveToFavorites(MoviesModels movie) {
    SignInScreen signInScreen = SignInScreen();

    isFavorited
        ? signInScreen.addFavoriteMovies([widget.movie])
        : signInScreen.removeFavoriteMovie(movie);

    print('Filme ${movie.title} foi adicionado/removido dos favoritos!');
  }
}
