import 'package:flutter/material.dart';
import '../models/character_model.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 600; // Si el ancho es mayor a 600px, usa diseño amplio.

          return SingleChildScrollView(
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: isWide ? 16 / 6 : 16 / 9, // Ajusta el ratio según el ancho.
                  child: Image.network(
                    character.imageUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.error, size: 50));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: _buildCharacterDetails(),
                            ),
                            Expanded(
                              flex: 1,
                              child: _buildCharacterStats(),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCharacterDetails(),
                            const SizedBox(height: 20),
                            _buildCharacterStats(),
                          ],
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCharacterDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Descripción:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          character.description,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildCharacterStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Género: ${character.gender}', style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 5),
        Text('Ki: ${character.ki}', style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 5),
        Text('Afiliación: ${character.affiliation}', style: const TextStyle(fontSize: 18)),
      ],
    );
  }
}
