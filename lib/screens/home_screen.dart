import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import '../services/api_services.dart';
import '../models/character_model.dart';
import '../widgets/character_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
      backgroundColor: const Color.fromARGB(255, 255, 242, 126), // Cambia el color según tu preferencia
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // Altura personalizada del AppBar
        child: AppBar(
          backgroundColor: const Color.fromARGB(179, 255, 115, 115), // Fondo transparente
          elevation: 0, // Sin sombra
          flexibleSpace: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/logo.png', // Ruta de la imagen del logo
                height: 80, // Ajusta la altura del logo
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Character>>(
        future: _characters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final characters = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: LayoutGrid(
                      columnSizes: [
                        if (MediaQuery.of(context).size.width > 1000) ...[
                          1.fr, 1.fr, 1.fr, 1.fr // 4 columnas
                        ] else if (MediaQuery.of(context).size.width > 600) ...[
                          1.fr, 1.fr, 1.fr // 3 columnas
                        ] else ...[
                          1.fr // 1 columna
                        ]
                      ],
                      rowSizes: List.generate(
                        (characters.length /
                                (MediaQuery.of(context).size.width > 600
                                    ? 3
                                    : 1))
                            .ceil(),
                        (index) => auto,
                      ),
                      rowGap: 10,
                      columnGap: 10,
                      children: characters
                          .map((character) =>
                              CharacterCard(character: character))
                          .toList(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _loadNextPage,
                  child: const Text('Cargar más'),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No se encontraron personajes.'));
          }
        },
      ),
    );
  }
}
