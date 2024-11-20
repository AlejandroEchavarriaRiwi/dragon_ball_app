import 'package:dio/dio.dart';
import '../models/character_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Character>> fetchCharacters({int page = 1, int limit =8}) async {
    try {
      final response = await _dio.get(
        'https://dragonball-api.com/api/characters',
        queryParameters: {'page': page, 'limit': limit},
      );

      // Accedemos a la lista de personajes dentro de `items`
      List<Character> characters = (response.data['items'] as List)
          .map((json) => Character.fromJson(json))
          .toList();

      return characters;
    } catch (e) {
      throw Exception('Error al cargar personajes: $e');
    }
  }
}
