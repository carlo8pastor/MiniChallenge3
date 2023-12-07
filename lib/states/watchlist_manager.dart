import 'package:flutter/material.dart';
import '../models/movie.dart';

class WatchlistProvider extends ChangeNotifier {
  List<Movie> _watchlist = [];

  List<Movie> get watchlist => _watchlist;

  void addToWatchlist(Movie movie) {
    _watchlist.add(movie);
    notifyListeners();
  }

  void removeFromWatchlist(Movie movie) {
    _watchlist.remove(movie);
    notifyListeners();
  }
}
