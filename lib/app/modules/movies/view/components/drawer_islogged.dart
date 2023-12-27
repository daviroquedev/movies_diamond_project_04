import 'package:flutter/material.dart';

class SearchDrawer extends StatefulWidget {
  const SearchDrawer({Key? key}) : super(key: key);

  @override
  _SearchDrawerState createState() => _SearchDrawerState();
}

class _SearchDrawerState extends State<SearchDrawer> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_searchController.text.length >= 3) {
      _searchMovies(_searchController.text);
    }
  }

  void _searchMovies(String query) {
    // Implemente aqui a chamada da rota da API para buscar os filmes com base na query
    // Esta função será chamada automaticamente quando o texto digitado no campo de busca tiver 3 ou mais caracteres
    // Use a variável "query" para enviar os parâmetros necessários à rota da API
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text('Nome do Usuário'), // Nome do usuário
            accountEmail: Text('email@exemplo.com'), // E-mail do usuário
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person), // Imagem de perfil padrão
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
