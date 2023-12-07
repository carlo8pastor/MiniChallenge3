import 'tmdb_service.dart';

class PopularService {
  final TMDBService _tmdbService;

  PopularService(this._tmdbService);

  Future<List<dynamic>> getPopularMovies() async {
    var response = await _tmdbService.dio.get('/movie/popular', queryParameters: {
      'language': 'en-US',
      'page': 1,
    });
    return response.data['results'];
  }
}
