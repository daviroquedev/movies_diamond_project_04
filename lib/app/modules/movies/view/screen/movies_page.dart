import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/movies/models/movies_models.dart';
import 'package:movies_diamond_project_03/app/modules/movies/store/movies_store.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/components/app_bar_logged.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/components/carrousel_cards.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/components/section_movies_cards.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/screen/drawer_islogged.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  MoviesScreenState createState() => MoviesScreenState();
}

class MoviesScreenState extends State<MoviesScreen> {
  final MoviesStore moviesStore = Modular.get<MoviesStore>();

  @override
  void initState() {
    super.initState();
    // Chama os métodos de busca ao iniciar a tela
    moviesStore.fetchPopularMovies();
    moviesStore.fetchRandomMovies();
    moviesStore.fetchOldMovies();
    moviesStore.fetchTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarLogged(),
      drawer: const SearchDrawer(),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Observer(
              builder: (_) {
                final popularMoviesFuture = moviesStore.popularMoviesFuture;
                final randomMoviesFuture = moviesStore.randomMoviesFuture;
                final oldMoviesFuture = moviesStore.oldMoviesFuture;
                final topRatedMoviesFuture = moviesStore.topRatedMoviesFuture;

                if (popularMoviesFuture == null ||
                    randomMoviesFuture == null ||
                    oldMoviesFuture == null) {
                  return const Center(child: CircularProgressIndicator());
                } else if (popularMoviesFuture.value == null ||
                    randomMoviesFuture.value == null ||
                    oldMoviesFuture.value == null ||
                    topRatedMoviesFuture == null ||
                    topRatedMoviesFuture.value == null) {
                  // Handle caso em que os dados ainda estão sendo carregados
                  return const Center(child: CircularProgressIndicator());
                } else if (popularMoviesFuture.error != null ||
                    randomMoviesFuture.error != null ||
                    oldMoviesFuture.error != null ||
                    topRatedMoviesFuture.error != null) {
                  // Handle caso de erro ao carregar os dados
                  return Center(
                    child: Text(
                      'Erro ao carregar os filmes: ${popularMoviesFuture.error}',
                    ),
                  );
                } else {
                  // Aqui, popularMoviesFuture.value contém os dados carregados
                  final popularMovies =
                      (popularMoviesFuture.value as List<dynamic>)
                          .map((movie) => MoviesModels.fromJson(movie))
                          .toList();

                  final randomMovies =
                      (randomMoviesFuture.value as List<dynamic>)
                          .map((movie) => MoviesModels.fromJson(movie))
                          .toList();

                  final oldMovies = (oldMoviesFuture.value as List<dynamic>)
                      .map((movie) => MoviesModels.fromJson(movie))
                      .toList();

                  final topRatedMovies =
                      (topRatedMoviesFuture.value as List<dynamic>)
                          .map((movie) => MoviesModels.fromJson(movie))
                          .toList();

                  // Utilize os dados para renderizar na UI
                  return Column(
                    children: [
                      MovieBannerCarousel(movies: topRatedMovies),
                      buildMovieSection(
                          title: 'Trending Topics', movies: popularMovies),
                      const SizedBox(height: 20),
                      buildMovieSection(
                          title: 'Random Movies', movies: randomMovies),
                      const SizedBox(height: 20),
                      buildMovieSection(title: 'Old Movies', movies: oldMovies),
                    ],
                  );
                }
              },
            )
            // Restante do seu código para outras seções de filmes usando o Observer
          ],
        ),
      ),
    );
  }
}
