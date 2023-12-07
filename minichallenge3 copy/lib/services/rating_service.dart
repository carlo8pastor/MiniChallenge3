import 'tmdb_service.dart';

class RatingService {
  final TMDBService _tmdbService;

  RatingService(this._tmdbService);

  Future<dynamic> addRating(int movieId, double rating) async {
    return await _tmdbService.dio.post('/movie/$movieId/rating', data: {'value': rating});
  }

  Future<dynamic> deleteRating(int movieId) async {
    return await _tmdbService.dio.delete('/movie/$movieId/rating');
  }
}
