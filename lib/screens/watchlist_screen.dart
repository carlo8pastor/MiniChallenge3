import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/states/watchlist_manager.dart';

class WatchlistScreen extends StatefulWidget {
  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var watchlistProvider = Provider.of<WatchlistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : watchlistProvider.watchlist.isEmpty
              ? Center(
                  child: Text('No movies in the watchlist'),
                )
              : ListView.builder(
                  itemCount: watchlistProvider.watchlist.length,
                  itemBuilder: (context, index) {
                    var movie = watchlistProvider.watchlist[index];
                    return ListTile(
                      title: Text(movie.title),
                    );
                  },
                ),
    );
  }
}
