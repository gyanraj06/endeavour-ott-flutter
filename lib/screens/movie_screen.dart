import 'package:endeavour/movie_widget/get_genres.dart';
import 'package:endeavour/movie_widget/now_playing_widget.dart';
import 'package:endeavour/movie_widget/movie_widget.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        NowPlaying(),                                           //Now Playing List
        GetGenres(),                                            //Genre column
        MoviesWidget(text: 'UPCOMING', request: 'upcoming'),    //Upcoming Movies
        MoviesWidget(text: 'POPULAR', request: 'popular'),      //Popular Movies
        MoviesWidget(text: 'TOP RATED', request: 'top_rated'),  //Top Rated Movies 
      ],
    );
  }
}
