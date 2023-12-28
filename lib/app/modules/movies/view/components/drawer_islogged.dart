import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_diamond_project_03/app/modules/movies/service/movies_service.dart';

class SearchDrawer extends StatefulWidget {
  const SearchDrawer({Key? key}) : super(key: key);

  @override
  SearchDrawerState createState() => SearchDrawerState();
}

class SearchDrawerState extends State<SearchDrawer> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel(); // Cancela o timer quando o widget é descartado
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (_searchController.text.length >= 3) {
        _searchMovies(_searchController.text);
      }
    });
  }

  Future<void> _searchMovies(String query) async {
    try {
      final List<dynamic> results =
          await Modular.get<MoviesService>().searchMovies(query);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      print('Erro ao buscar filmes: $e');
    }
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
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Pesquisar filmes',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                if (_searchResults.isNotEmpty)
                  Column(
                    children: _searchResults.map((result) {
                      return ListTile(
                        title: Text(result['title']),
                        onTap: () {
                          // logica de selecionar um filme da lista
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
