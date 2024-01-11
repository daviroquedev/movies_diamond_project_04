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
    fetchMovies();
  }

  void fetchMovies() {
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
        child: Observer(
          builder: (_) {
            return _buildMoviesContent();
          },
        ),
      ),
    );
  }

  Widget _buildMoviesContent() {
    final popularMoviesFuture = moviesStore.popularMoviesFuture;
    final randomMoviesFuture = moviesStore.randomMoviesFuture;
    final oldMoviesFuture = moviesStore.oldMoviesFuture;
    final topRatedMoviesFuture = moviesStore.topRatedMoviesFuture;

    if (popularMoviesFuture == null ||
        randomMoviesFuture == null ||
        oldMoviesFuture == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (popularMoviesFuture.result == null ||
        randomMoviesFuture.result == null ||
        oldMoviesFuture.result == null ||
        topRatedMoviesFuture == null ||
        topRatedMoviesFuture.result == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (popularMoviesFuture.error != null ||
        randomMoviesFuture.error != null ||
        oldMoviesFuture.error != null ||
        topRatedMoviesFuture.error != null) {
      return _buildErrorWidget();
    } else {
      return _buildMoviesSections();
    }
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Text(
        'Erro ao carregar os filmes: ${moviesStore.popularMoviesFuture?.error}',
      ),
    );
  }

  Widget _buildMoviesSections() {
    final popularMovies =
        _getMoviesList(moviesStore.popularMoviesFuture?.result);
    final randomMovies = _getMoviesList(moviesStore.randomMoviesFuture?.result);
    final oldMovies = _getMoviesList(moviesStore.oldMoviesFuture?.result);
    final topRatedMovies =
        _getMoviesList(moviesStore.topRatedMoviesFuture?.result);

    return Column(
      children: [
        MovieBannerCarousel(movies: topRatedMovies),
        _buildMovieSection(title: 'Trending Topics', movies: popularMovies),
        const SizedBox(height: 20),
        _buildMovieSection(title: 'Random Movies', movies: randomMovies),
        const SizedBox(height: 20),
        _buildMovieSection(title: 'Old Movies', movies: oldMovies),
      ],
    );
  }

  Widget _buildMovieSection(
      {required String title, required List<MoviesModels> movies}) {
    return buildMovieSection(title: title, movies: movies);
  }

  List<MoviesModels> _getMoviesList(List<dynamic>? movies) {
    return (movies as List<dynamic>)
        .map((movie) => MoviesModels.fromJson(movie))
        .toList();
  }
}
