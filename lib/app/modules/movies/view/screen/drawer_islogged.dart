import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/movies/controller/search_movies_controller.dart';
import 'package:movies_diamond_project_03/app/modules/movies/models/movies_models.dart';
import 'package:movies_diamond_project_03/app/modules/movies/service/movie_detailed_service.dart';

class SearchDrawer extends StatefulWidget {
  const SearchDrawer({Key? key}) : super(key: key);

  @override
  SearchDrawerState createState() => SearchDrawerState();
}

class SearchDrawerState extends State<SearchDrawer> {
  final SearchMoviesController _searchMoviesController =
      SearchMoviesController();
  bool _showNoResultsMessage =
      false; // Variável para controlar a exibição da mensagem

  @override
  void initState() {
    super.initState();
    _searchMoviesController.initSearchListener(_updateResults);
  }

  void _updateResults(List<dynamic> results) {
    setState(() {
      _searchMoviesController.searchResults = results;
      _showNoResultsMessage = results.isEmpty &&
          _searchMoviesController.searchController.text.length >= 3;
    });
  }

  @override
  void dispose() {
    _searchMoviesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text('Nome do Usuário'),
            accountEmail: Text('email@exemplo.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _searchMoviesController.searchController,
                  decoration: const InputDecoration(
                    labelText: 'Pesquisar filmes',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                if (_showNoResultsMessage)
                  const Text(
                    'Nenhum filme encontrado',
                    style: TextStyle(color: Colors.red),
                  ),
                if (_searchMoviesController.searchResults.isNotEmpty)
                  Column(
                    children:
                        _searchMoviesController.searchResults.map((result) {
                      final posterPath = result['poster_path'];
                      return ListTile(
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: posterPath != null && posterPath.isNotEmpty
                                ? Image.network(
                                    'https://image.tmdb.org/t/p/w500$posterPath',
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/placeholder_noimg.png',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        title: Text(result['title']),
                        onTap: () {
                          MoviesModels movie = MoviesModels.fromJson(result);
                          Modular.to.pushNamed(
                            '/movies/detailed/${result['id']}',
                            arguments: movie,
                          );
                        },
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
