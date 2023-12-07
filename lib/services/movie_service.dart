import 'tmdb_service.dart';

class MovieDiscoveryService {
  final TMDBService _tmdbService;

  MovieDiscoveryService(this._tmdbService);

  Future<List<dynamic>> discoverMovies(String query) async {
    var response = await _tmdbService.dio.get('/search/movie', queryParameters: {
      'query': query,
      'include_adult': false,
      'language': 'en-US',
      'page': 1,
    });
    return response.data['results'];
  }

  Future<dynamic> discoverTvShows() async {
    return await _tmdbService.dio.get('/discover/tv', queryParameters: {
      'include_adult': false,
      'include_null_first_air_dates': false,
      'language': 'en-US',
      'page': 1,
      'sort_by': 'popularity.desc',
    });
  }
}
