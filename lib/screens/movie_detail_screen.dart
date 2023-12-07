import 'package:flutter/material.dart';
import '../services/details_service.dart';
import '/services/tmdb_service.dart';
import 'package:provider/provider.dart';
import '/states/watchlist_manager.dart';
import '/models/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  MovieDetailScreen({required this.movieId});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late DetailsService _detailsService;
  dynamic _movieDetails;
  bool _isLoading = true;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _detailsService = DetailsService(TMDBService());
    _fetchMovieDetails();
  }

  void _fetchMovieDetails() async {
    var details = await _detailsService.getMovieDetails(widget.movieId);
    setState(() {
      _movieDetails = details;
      _isLoading = false;
    });
  }

  void _toggleSaved(WatchlistProvider watchlistProvider) {
    setState(() {
      _isSaved = !_isSaved;
      if (_isSaved) {
        watchlistProvider.addToWatchlist(
          Movie(
            id: _movieDetails['id'],
            title: _movieDetails['title'],
          ),
        );
      } else {
        watchlistProvider.removeFromWatchlist(
          Movie(
            id: _movieDetails['id'],
            title: _movieDetails['title'],
          ),
        );
      }
    });
  }

  Widget buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$title:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    var movie = _movieDetails['details'];
    var director = _movieDetails['credits']['crew'].firstWhere(
      (crewMember) => crewMember['job'] == 'Director',
      orElse: () => null
    );
    var castMembers = _movieDetails['credits']['cast'].map((cast) => cast['name']).join(', ');
    int duration = movie['runtime'];
    String formattedDuration = '${duration ~/ 60}h ${duration % 60}min';

    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title']),
        actions: [
          Consumer<WatchlistProvider>(
            builder: (context, watchlistProvider, child) {
              return IconButton(
                icon: Icon(
                  watchlistProvider.watchlist.contains(
                    Movie(id: movie['id'], title: movie['title']),
                  )
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                onPressed: () => _toggleSaved(watchlistProvider),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildDetailItem('Release Date', movie['release_date']),
              buildDetailItem('Genres', movie['genres'].map((g) => g['name']).join(', ')),
              buildDetailItem('Duration', formattedDuration),
              buildDetailItem('Rating', '${movie['vote_average']} / 10'),
              buildDetailItem('Summary', movie['overview']),
              buildDetailItem('PEGI Rating', movie['release_dates']?['certification'] ?? 'N/A'),
              buildDetailItem('Director', director != null ? director['name'] : 'N/A'),
              buildDetailItem('Cast', castMembers),
            ],
          ),
        ),
      ),
    );
  }
}
