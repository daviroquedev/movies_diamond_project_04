import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/movies/models/movies_models.dart';
import 'package:movies_diamond_project_03/app/modules/movies/service/movies_service.dart';
import 'package:movies_diamond_project_03/app/modules/movies/view/components/row_cards.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final MoviesService _moviesService = Modular.get();
  late List<MoviesModels> _movies =
      []; // Alteração: Usar a classe Movie em vez de dynamic

  @override
  void initState() {
    super.initState();
    fetchMovies();
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
      body: _movies.isNotEmpty
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildMovieRows(),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  List<Widget> _buildMovieRows() {
    final List<Widget> rows = [];

    for (int i = 0; i < _movies.length; i += 20) {
      final moviesSubset = _movies.skip(i).take(20).toList();
      rows.add(_buildMovieRow(moviesSubset));
    }

    return rows;
  }

  Widget _buildMovieRow(List<dynamic> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Trending Topics',
            style: TextStyle(
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
    return Padding(
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
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}', // Alteração: Acessar os atributos da classe Movie
                    fit: BoxFit.cover,
                    height: 180,
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Text(
                    movie
                        .title, // Alteração: Acessar os atributos da classe Movie
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
