import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/movies/models/movies_models.dart';
import 'package:movies_diamond_project_03/app/modules/movies/service/movies_service.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/components/drawer_islogged.dart';

import 'package:movies_diamond_project_03/app/modules/movies/view/components/movie_cards.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  MoviesScreenState createState() => MoviesScreenState();
}

class MoviesScreenState extends State<MoviesScreen> {
  final MoviesService _moviesService = Modular.get();
  late List<MoviesModels> _movies = [];
  late List<MoviesModels> _randomMovies = [];
  late List<MoviesModels> _oldMovies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
    fetchRandomMovies();
    fetchOldMovies();
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
      });
    } catch (e) {
      print('Erro ao carregar os filmes: $e');
    }
  }

  Future<void> fetchOldMovies() async {
    try {
      final oldMovies = await _moviesService.fetchOldMovies();
      setState(() {
        _oldMovies =
            oldMovies.map((json) => MoviesModels.fromJson(json)).toList();

        print('OLDS api ${_oldMovies.toString()}');
      });
    } catch (e) {
      print('Erro ao carregar os filmes: $e');
    }
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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  'assets/images/diamond_logo.png',
                  fit: BoxFit.contain,
                  height: 90,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMovieSection('Trending Topics', _movies),
                        const SizedBox(height: 20),
                        _buildMovieSection('Random Movies', _randomMovies),
                        const SizedBox(height: 20),
                        _buildMovieSection('Old Movies', _oldMovies),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
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
