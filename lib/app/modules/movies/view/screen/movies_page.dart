import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/movies/models/movies_models.dart';
import 'package:movies_diamond_project_03/app/modules/movies/store/movies_store.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/components/drawer_islogged.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/components/movie_cards.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              color: Colors.white,
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.navigate('/');
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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

                if (popularMoviesFuture == null ||
                    randomMoviesFuture == null ||
                    oldMoviesFuture == null) {
                  return const Center(child: CircularProgressIndicator());
                } else if (popularMoviesFuture.value == null ||
                    randomMoviesFuture.value == null ||
                    oldMoviesFuture.value == null) {
                  // Handle caso em que os dados ainda estão sendo carregados
                  return const Center(child: CircularProgressIndicator());
                } else if (popularMoviesFuture.error != null ||
                    randomMoviesFuture.error != null ||
                    oldMoviesFuture.error != null) {
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

                  // Utilize os dados para renderizar na UI
                  return Column(
                    children: [
                      _buildMovieSection(
                          title: 'Trending Topics', movies: popularMovies),
                      const SizedBox(height: 20),
                      _buildMovieSection(
                          title: 'Random Movies', movies: randomMovies),
                      const SizedBox(height: 20),
                      _buildMovieSection(
                          title: 'Old Movies', movies: oldMovies),
                      // Adicione mais seções se desejar
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

  Widget _buildMovieSection(
      {required String title, required List<MoviesModels> movies}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 247, 247, 247),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: movies.map((movie) => _buildMovieCard(movie)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMovieCard(MoviesModels movie) {
    return MovieCard(movie: movie);
  }
}
