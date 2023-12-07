import 'tmdb_service.dart';

class GuestSessionService {
  final TMDBService _tmdbService;

  GuestSessionService(this._tmdbService);

  Future<dynamic> createGuestSession() async {
    return await _tmdbService.dio.get('/authentication/guest_session/new');
  }
}
