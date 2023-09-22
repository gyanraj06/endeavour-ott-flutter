import 'package:endeavour/widgets/tv_widget/airing.dart';
import 'package:endeavour/widgets/tv_widget/get_genre.dart';
import 'package:endeavour/widgets/tv_widget/tv_widget.dart';
import 'package:flutter/material.dart';

class TVsScreen extends StatefulWidget {
  const TVsScreen({Key? key}) : super(key: key);

  @override
  State<TVsScreen> createState() => _TVsScreenState();
}

class _TVsScreenState extends State<TVsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        AiringToday(),
        GetGenres(),
        TVsWidget(text: "UPCOMING", request: "on_the_air"),
        TVsWidget(text: "POPULAR", request: "popular"),
        TVsWidget(text: "TOP RATED", request: "top_rated"),
      ],
    );
  }
}
