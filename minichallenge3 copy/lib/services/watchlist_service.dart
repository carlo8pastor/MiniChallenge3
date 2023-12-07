import 'tmdb_service.dart';

class WatchlistService {
  final TMDBService _tmdbService;
  final String _accountId;

  WatchlistService(this._tmdbService, this._accountId);

  Future<dynamic> addToWatchlist(int movieId) async {
    return await _tmdbService.dio.post('/account/$_accountId/watchlist', data: {
      'media_type': 'movie',
      'media_id': movieId,
      'watchlist': true
    });
  }

  Future<dynamic> getWatchlistMovies() async {
    return await _tmdbService.dio.get('/account/$_accountId/watchlist/movies', queryParameters: {
      'language': 'en-US',
      'page': 1,
      'sort_by': 'created_at.asc',
    });
  }
}
