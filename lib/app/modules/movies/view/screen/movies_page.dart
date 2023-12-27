import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/movies/models/movies_models.dart';
import 'package:movies_diamond_project_03/app/modules/movies/service/movies_service.dart';

import 'package:movies_diamond_project_03/app/modules/movies/view/components/movie_cards.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final MoviesService _moviesService = Modular.get();
  late List<MoviesModels> _movies = [];
  late List<MoviesModels> _randomMovies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
    fetchRandomMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final movies = await _moviesService.fetchPopularMovies();
      setState(() {
        _movies = movies
            .map((json) => MoviesModels.fromJson(json))
            .toList(); // Alteração: Mapear os filmes para a classe Movie
      });
    } catch (e) {
      print('Erro ao carregar os filmes: $e');
    }
  }

  Future<void> fetchRandomMovies() async {
    try {
      final randomMovies = await _moviesService.fetchRandomMovies();
      setState(() {
        _randomMovies =
            randomMovies.map((json) => MoviesModels.fromJson(json)).toList();

        print('randomm moveis api ${_randomMovies.toString()}');
      });
    } catch (e) {
      print('Erro ao carregar os filmes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/diamond_logo.png',
              fit: BoxFit.cover,
              height: 60,
              filterQuality: FilterQuality.high,
            ),
            Positioned(
              right: 8,
              child: IconButton(
                onPressed: () {
                  Modular.to.navigate('/');
                },
                icon: const Icon(Icons.exit_to_app, color: Colors.white),
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMovieSection('Trending Topics', _movies),
            const SizedBox(height: 20),
            _buildMovieSection('Random Movies', _randomMovies),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieSection(String title, List<MoviesModels> movies) {
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
