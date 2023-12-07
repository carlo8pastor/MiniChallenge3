import '/services/tmdb_service.dart';

class DetailsService {
  final TMDBService _tmdbService;

  DetailsService(this._tmdbService);

  Future<dynamic> getMovieDetails(int movieId) async {
    var movieDetails = await _tmdbService.dio.get('/movie/$movieId', queryParameters: {
      'language': 'en-US',
    });
    var movieCredits = await _tmdbService.dio.get('/movie/$movieId/credits', queryParameters: {
      'language': 'en-US',
    });
    return {
      'details': movieDetails.data,
      'credits': movieCredits.data
    };
  }
}
