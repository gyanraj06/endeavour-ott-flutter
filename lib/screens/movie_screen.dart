import 'package:endeavour/widgets/movie_widgets/get_genre.dart';
import 'package:endeavour/widgets/movie_widgets/now_playing.dart';
import 'package:endeavour/widgets/movie_widgets/movie_widget.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        NowPlaying(),
        GetGenres(),
        MovieWidget(text: 'NOW PLAYING', request: 'now_playing'),
        MovieWidget(text: 'UPCOMING', request: 'upcoming'),
        MovieWidget(text: 'POPULAR', request: 'popular'),
        MovieWidget(text: 'TOP RATED', request: 'top_rated'),
      ],
    );
  }
}
