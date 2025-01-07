import 'package:dio/dio.dart';

class RickAndMortyService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<dynamic>> getCharacters() async {
    final response = await _dio.get('$_baseUrl/character');
    return response.data['results'];
  }

  Future<List<dynamic>> fetchEpisodes(List<dynamic> episodeUrls) async {
    final List<String> urls = episodeUrls.cast<String>();
    final List<dynamic> episodes = [];

    for (var url in urls) {
      final response = await _dio.get(url);
      episodes.add(response.data);
    }
    return episodes;
  }
}
