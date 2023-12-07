import 'package:flutter/material.dart';
import '/services/popular_service.dart';
import '/services/tmdb_service.dart';
import 'movie_detail_screen.dart';

class PopularScreen extends StatefulWidget {
  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  late PopularService _popularService;
  List<dynamic> _movies = [];

  @override
  void initState() {
    super.initState();
    _popularService = PopularService(TMDBService());
    _fetchPopularMovies();
  }

  void _fetchPopularMovies() async {
    var movies = await _popularService.getPopularMovies();
    setState(() {
      _movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          var movie = _movies[index];
          var posterUrl = 'https://image.tmdb.org/t/p/w500${movie['poster_path']}';

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(movieId: movie['id']),
                ),
              );
            },
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Colors.black45,
                title: Text(
                  movie['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              child: Image.network(posterUrl, fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
