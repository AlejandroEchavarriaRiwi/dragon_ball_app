import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/character_model.dart';
import '../widgets/character_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Character>> _characters;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _characters = _apiService.fetchCharacters(page: _currentPage);
  }

  void _loadNextPage() {
    setState(() {
      _currentPage++;
      _characters = _apiService.fetchCharacters(page: _currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dragon Ball Characters')),
      body: FutureBuilder<List<Character>>(
        future: _characters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final characters = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      return CharacterCard(character: characters[index]);
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _loadNextPage,
                  child: Text('Cargar más'),
                ),
              ],
            );
          } else {
            return Center(child: Text('No se encontraron personajes.'));
          }
        },
      ),
    );
  }
}
